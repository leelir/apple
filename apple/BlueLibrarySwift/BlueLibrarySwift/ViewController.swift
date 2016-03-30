/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {

	@IBOutlet var dataTable: UITableView!
	@IBOutlet var toolbar: UIToolbar!
    @IBOutlet var scroller: HorizontalScroller!
    
    private var allAlbums = [Album]()
    private var currentAlbumData : (titles:[String], values:[String])?
    private var currentAlbumIndex = 0

	
	override func viewDidLoad() {
		super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        currentAlbumIndex = 0
        allAlbums = LibraryAPI.sharedInstance.getAlbums()
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        view.addSubview(dataTable!)
        self.showDataForAlbum(currentAlbumIndex)
        scroller.delegate = self
        reloadScroller()
    }
    
    
    func showDataForAlbum(albumIndex: Int) {
        // 保证代码健壮性，确保专辑数至少大于0，避免数组下标越界的错误
        if (albumIndex < allAlbums.count && albumIndex > -1) {
            //获取专辑对象
            let album = allAlbums[albumIndex]
            // 保存专辑的数据，用于一会在tableview中展现
            currentAlbumData = album.ae_tableRepresentation()
        } else {
            currentAlbumData = nil
        }
        // 我们已经获取到了需要的数据，可以刷新tableview来显示数据了
        dataTable!.reloadData()
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    func reloadScroller() {
        allAlbums = LibraryAPI.sharedInstance.getAlbums()
        if currentAlbumIndex < 0 {
            currentAlbumIndex = 0
        } else if currentAlbumIndex >= allAlbums.count {
            currentAlbumIndex = allAlbums.count - 1
        }
        scroller.reload()
        showDataForAlbum(currentAlbumIndex)
    }


}
    extension ViewController: UITableViewDataSource {
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let albumData = currentAlbumData {
                return albumData.titles.count
            } else {
                return 0
            }
        }
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->         UITableViewCell {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            if let albumData = currentAlbumData {
                cell.textLabel?.text = albumData.titles[indexPath.row]
                if let detailTextLabel = cell.detailTextLabel {
                    detailTextLabel.text = albumData.values[indexPath.row]
                }
            }
            return cell
        }
    }
extension ViewController: HorizontalScrollerDelegate {
    func horizontalScrollerClickedViewAtIndex(scroller: HorizontalScroller, index: Int) {
        //1
        let previousAlbumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
        previousAlbumView.highlightAlbum(didHighlightView: false)
        //2
        currentAlbumIndex = index
        //3
        let albumView = scroller.viewAtIndex(index) as! AlbumView
        albumView.highlightAlbum(didHighlightView: true)
        //4
        showDataForAlbum(index)
    }
    func numberOfViewsForHorizontalScroller(scroller: HorizontalScroller) -> (Int) {
        return allAlbums.count
    }
    func horizontalScrollerViewAtIndex(scroller: HorizontalScroller, index: Int) -> (UIView) {
        let album = allAlbums[index]
        let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), albumCover: album.coverUrl)
        if currentAlbumIndex == index {
            albumView.highlightAlbum(didHighlightView: true)
        } else {
            albumView.highlightAlbum(didHighlightView: false)
        }
        return albumView
    }
    
}

extension ViewController: UITableViewDelegate {
}

