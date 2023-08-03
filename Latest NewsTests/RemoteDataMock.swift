//
//  RemoteDataMock.swift
//  Latest NewsTests
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import Foundation
@testable import Latest_News


final class RemoteDataMock{
    let articleData = "{\"status\":\"ok\",\"totalResults\":15247,\"articles\":[{\"source\":{\"id\":null,\"name\":\"Fark.com\"},\"author\":null,\"title\":\"Elmo:Xisgoingtobetheeverythingapp.Inthemeantime,XstandsforLighthouse[Fail]\",\"description\":\"Elmo:Xisgoingtobetheeverythingapp.Inthemeantime,XstandsforLighthouse\",\"url\":\"https://www.fark.com/comments/12941098/Elmo-X-is-going-to-be-everything-app-In-meantime-X-stands-for-Lighthouse\",\"urlToImage\":\"https://usrimg-full.fark.net/6/6i/fark_6icC6KS-maO8CzQ9Oh2xMpBcp64.png?AWSAccessKeyId=UKDINQXVGV49TCSSKJLK&Expires=1690776000&Signature=haVwU6FMhTbKcXFm4Zh23xVMi8o%3D\",\"publishedAt\":\"2023-07-30T02:25:59Z\",\"content\":\"Yes,afterElmo'sstablerelationshipasownerofTwitter,thefirstthingIwanttodoisgivehimallmybankingandbillinginformation.Imean,it'snotlikehechangesthingsatthedropofhis…[+241chars]\"},{\"source\":{\"id\":\"google-news\",\"name\":\"GoogleNews\"},\"author\":null,\"title\":\"Stateconfirms1stcaseofequineWestNilevirusof2023inWeldCountygelding-GreeleyTribune\",\"description\":\"<ol><li>Stateconfirms1stcaseofequineWestNilevirusof2023inWeldCountygeldingGreeleyTribune\\r\\n</li><li>MosquitoCarryingWestNileVirusFoundinTwinFallsCountyTimes-News\\r\\n</li><li>NewMexicoseesfirsthumanWestNilevirusinfectionsof20…\",\"url\":\"https://consent.google.com/ml?continue=https://news.google.com/rss/articles/CBMie2h0dHBzOi8vd3d3LmdyZWVsZXl0cmlidW5lLmNvbS8yMDIzLzA3LzI5L3N0YXRlLWNvbmZpcm1zLTFzdC1jYXNlLW9mLWVxdWluZS13ZXN0LW5pbGUtdmlydXMtb2YtMjAyMy1pbi13ZWxkLWNvdW50eS1nZWxkaW5nL9IBf2h0dHBzOi8vd3d3LmdyZWVsZXl0cmlidW5lLmNvbS8yMDIzLzA3LzI5L3N0YXRlLWNvbmZpcm1zLTFzdC1jYXNlLW9mLWVxdWluZS13ZXN0LW5pbGUtdmlydXMtb2YtMjAyMy1pbi13ZWxkLWNvdW50eS1nZWxkaW5nL2FtcC8?oc%3D5&gl=FR&hl=en-US&cm=2&pc=n&src=1\",\"urlToImage\":null,\"publishedAt\":\"2023-07-30T02:24:13Z\",\"content\":\"Weusecookiesanddatato<ul><li>DeliverandmaintainGoogleservices</li><li>Trackoutagesandprotectagainstspam,fraud,andabuse</li><li>Measureaudienceengagementandsitestatisticstounde…[+1131chars]\"},{\"source\":{\"id\":null,\"name\":\"DailyMail\"},\"author\":\"ChrisPollard\",\"title\":\"AftertherowoverLondon'sUlezexpansion...NowLabourcouncilhitsdieseldriverswithhigherparkingfees\",\"description\":\"ALabour-runcouncilischargingmotoristsextratoparkpollutingcarsinadoubleblowforthoseabouttobehitbytheexpansionofLondon'shatedUlezfee.\",\"url\":\"https://www.dailymail.co.uk/news/article-12352169/After-row-Londons-Ulez-expansion-Labour-council-hits-diesel-drivers-higher-parking-fees.html\",\"urlToImage\":\"https://i.dailymail.co.uk/1s/2023/07/29/18/73753489-0-image-a-6_1690652830553.jpg\",\"publishedAt\":\"2023-07-29T21:03:07Z\",\"content\":\"ALabour-runcouncilischargingmotoristsextratoparkpollutingcarsinadoubleblowforthoseabouttobehitbytheexpansionofLondon'shatedUlezfee.\\r\\nTherearefearsthatotherLabour-run…[+3698chars]\"},{\"source\":{\"id\":null,\"name\":\"Biztoc.com\"},\"author\":\"businessinsider.com\",\"title\":\"The'richcession'isn'thappening.Theultra-wealthyhaveneverbeenricherandthey'restillspendinglikecrazy\",\"description\":\"ScottBarbour/GettyImagesThe\\\"richcession\\\"-arecessionthatdisproportionatelyimpactsthewealthy,isn'tinthecards.Expertssaytherichestareactuallyevenricherandspendingmorethantheywerebeforethepandemic.Youcanthankrisingstockprice…\",\"url\":\"https://biztoc.com/x/c7dc46184c17aaa1\",\"urlToImage\":\"https://c.biztoc.com/p/c7dc46184c17aaa1/s.webp\",\"publishedAt\":\"2023-07-29T13:42:04Z\",\"content\":\"ScottBarbour/GettyImagesThe\\\"richcession\\\"-arecessionthatdisproportionatelyimpactsthewealthy,isn'tinthecards.Expertssaytherichestareactuallyevenricherandspendingmorethanthey…[+282chars]\"}]}"
}

extension RemoteDataMock : RemoteDataSourceProtocol{
    func getNews(compilitionHandler: @escaping (Latest_News.AllNews?) -> Void) {
        let data = Data (articleData.utf8)
        do{
            let result = try JSONDecoder().decode(AllNews.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
}
