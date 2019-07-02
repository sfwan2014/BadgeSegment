# BadgeSegment



**用法**
let segment = IWBadgeSegment.init(frame: CGRect.init(x: 16, y: 50, width: UIScreen.main.bounds.size.width-16*2, height: 44), segmentTitles: ["西瓜","冬瓜","南瓜","北瓜"])
segment.badges?[1] = 8
self.view.addSubview(segment)
segment.addTarget(self, action: #selector(segmentAction), for: UIControl.Event.valueChanged)


let segment1 = IWBadgeSegment.init(frame: CGRect.init(x: 16, y: 50+50, width: UIScreen.main.bounds.size.width-16*2, height: 44), segmentTitles: ["西瓜","冬瓜","南瓜","北瓜"])
self.view.addSubview(segment1)
segment1.badges?[2] = 10
segment1.tintColor = UIColor.init(red: 0.3, green: 0.8, blue: 0.1, alpha: 1)
segment1.selectedTitleColor = UIColor.red
segment1.normalTitleColor = UIColor.darkGray
segment1.addTarget(self, action: #selector(segmentAction), for: UIControl.Event.valueChanged)



**截图**
<p align="center">
<img src="https://raw.githubusercontent.com/sfwan2014/BadgeSegment/master/CustomeBadgeSegmentDemo/example.png" alt="Kingfisher" title="Kingfisher" width="260"/>
</p>
