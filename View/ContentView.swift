//
//  ContentView.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 9/10/23.
//



import SwiftUI

struct ContentView: View {
    
    @State private var cityName: String = ""
    @State private var currentCity = "City"
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Image(colorScheme == .dark ? "BackgroundSkySpyDark" : "BackgroundSkySpy")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Título de la App
                Spacer().frame(height: 50)
                ZStack {
                    Text("SkySpy")
                        .font(Font.custom("SF Compact Rounded", size: 64.0))
                        .blur(radius: 3.0)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    Text("SkySpy")
                        .font(Font.custom("SF Compact Rounded", size: 64))
                        .foregroundStyle(.white)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                }
                .shadow(color: Color.black.opacity(0.6), radius: 10, x: 0, y: 10)
                
           
                
                // TextField para el nombre de la ciudad
                HStack() {
                    TextField("Introduce el nombre de la ciudad", text: $cityName, onCommit: {
                        // Acción que se ejecuta al pulsar "Enter"
                        print(cityName)
                        currentCity = cityName
                        DispatchQueue.main.async { cityName = "" }
                        
                    })
                    .padding(10)
                    .background(Color(UIColor.secondarySystemBackground).opacity(0.7))
                    .cornerRadius(10)
  
                    
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.6),
                            radius: 10, x: 0, y: 10)
                    .textInputAutocapitalization(.words)
                    
                    Button(action: {
                        // Acción que se ejecuta al pulsar el icono de lupa
                        print(cityName)
                        currentCity = cityName
                        DispatchQueue.main.async { cityName = "" }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.6),
                                    radius: 10, x: 0, y: 10)
                    }
                }
                .padding(.horizontal, 30)

                
                Spacer()  // Espacio entre el TextField y el área de la imagen
                
                // Campo de texto grande para los grados de temperatura
                Text("22°C")  // Puedes vincular esto a una variable si es necesario
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                
                // Campo de texto para indicar el nombre de la ciudad
                Text(currentCity)
                    .font(.title2)
                   
                 
                
                Spacer()  // Espacio entre los campos de texto y el área de la imagen
                
                // Área para la imagen en la parte inferior
                ZStack {
                    RoundedRectangle(cornerRadius: 30)  // Marcos
                        .fill(Color(UIColor.systemBackground))  // Fondo dinámico
                        .frame(height: 400)  // Ajusta la altura según lo necesites
                        .shadow(color: Color.black.opacity(0.6), radius: 10, x: 0, y: 10)
                    RoundedRectangle(cornerRadius: 30)  // Borde
                        .stroke(lineWidth: 8)
                        .frame(height: 400)  // Ajusta la altura según lo necesites
                        .foregroundColor(.gray)
                }
                .padding(30)  // Añade un poco de espacio alrededor del área de la imagen
                
            }
            
        }
    }
}




#Preview {
    ContentView()
}
