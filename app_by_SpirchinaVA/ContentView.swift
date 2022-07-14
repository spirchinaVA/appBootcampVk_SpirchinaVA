//  ContentView.swift
//  app_by_SpirchinaVA
//
//  Created by Victoria Spirchina on 13.07.2022.
//

import SwiftUI

struct vk: Codable {
  let body: Body
  let status: Int
}

struct Body: Codable {
  let services: [Service]
}

struct Service: Codable {
  let id = UUID()
  let name, serviceDescription: String
  let link: String
  let iconURL: String
  
  enum CodingKeys: String, CodingKey {
    case name
    case serviceDescription = "description"
    case link
    case iconURL = "icon_url"
  }
}

struct ContentView: View {
  var body: some View {
    
    let JSON = """
      {
      "body": {
        "services": [
          {
            "name": "ВКонтакте",
            "description": "Самая популярная соцсеть и первое суперприложение в России",
            "link": "https://vk.com/",
            "icon_url": "https://publicstorage.hb.bizmrg.com/sirius/vk.png"
          },
          {
            "name": "My.Games",
            "description": "Игры для ПК, консолей и смартфонов, в которые играют сотни миллионов геймеров",
            "link": "https://my.games/",
            "icon_url": "https://publicstorage.hb.bizmrg.com/sirius/mygames.png"
          },
          {
            "name": "Сферум",
            "description": "Онлайн-платформа для обучения и образовательных коммуникаций",
            "link": "https://sferum.ru/?p=start",
            "icon_url": "https://publicstorage.hb.bizmrg.com/sirius/sferum.png"
          },
          {
            "name": "Юла",
            "description": "Сервис объявлений на основе геолокации и интересов",
            "link": "https://youla.ru/",
            "icon_url": "https://publicstorage.hb.bizmrg.com/sirius/youla.png"
          },
          {
            "name": "Самокат",
            "description": "Онлайн-ретейлер с доставкой товаров за 15 минут",
            "link": "https://samokat.ru/",
            "icon_url": "https://publicstorage.hb.bizmrg.com/sirius/samokat.png"
          },
          {
            "name": "Ситидрайв",
            "description": "Каршеринг-сервис в крупнейших российских городах",
            "link": "https://citydrive.ru/",
            "icon_url": "https://publicstorage.hb.bizmrg.com/sirius/citydrive.png"
          },
          {
            "name": "Облако",
            "description": "Сервис для хранения файлов и совместной работы с ними",
            "link": "https://cloud.mail.ru/home/",
            "icon_url": "https://publicstorage.hb.bizmrg.com/sirius/cloud.png"
          },
          {
            "name": "Все аптеки",
            "description": "Онлайн-сервис для поиска и щзаказа лекарств по лучшей цене",
            "link": "https://vseapteki.ru/",
            "icon_url": "https://publicstorage.hb.bizmrg.com/sirius/apteki.png"
          },
          {
            "name": "Календарь",
            "description": "Планирование дня и эффективное управление временем",
            "link": "https://calendar.mail.ru/",
            "icon_url": "https://publicstorage.hb.bizmrg.com/sirius/calendar.png"
          }
        ]
      },
      "status": 200
      }
      """
    
    let jsonData = JSON.data(using: .utf8)!
    let vkService: vk = try! JSONDecoder().decode(vk.self, from: jsonData)
    
    NavigationView{
      ScrollView(.vertical){
        VStack {
          ForEach(vkService.body.services, id: \.id) { service in
            
            Button(action:{
              let url = NSURL(string: service.link)!.host
              var serviceName = url!.replacingOccurrences(of: ".ru", with: "")
              serviceName = serviceName.replacingOccurrences(of: ".com", with: "")
              let appUrl = URL(string: "\(serviceName)://app")!
              
              if UIApplication.shared.canOpenURL(appUrl) {
                UIApplication.shared.openURL(appUrl)
              } else {
                UIApplication.shared.openURL(URL(string: service.link)!)
              }
            }
            ){
              HStack {
                AsyncImage(url: URL(string: service.iconURL)) { image in
                  image.resizable()
                } placeholder: {
                  ProgressView()
                }.frame(width: 50, height: 50)
                
                VStack {
                  HStack {
                    Text(service.name).font(.headline).padding(.leading)
                    Spacer()
                  }
                  Text(service.serviceDescription)
                }.padding()
                
                Spacer()
                
              }.padding(.leading)
              
            }.navigationTitle("Сервисы ВК").buttonStyle(.plain)
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
