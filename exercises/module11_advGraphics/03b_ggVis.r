library(ggvis)
library(dplyr)

mtcars %>% ggvis(~disp,~mpg) %>% layer_points()
# plot mtcars dataset disp vs mpg

# points and smooths
mtcars %>% ggvis(~wt,~mpg, fill:="blue") %>% layer_points()   # blue points
mtcars %>% ggvis(~wt,~mpg) %>% layer_smooths()   # smooths
mtcars %>% ggvis(~wt,~mpg) %>% layer_points() %>% layer_smooths()   # points & smooth

faithful %>% ggvis(~waiting, ~eruptions,
                 size=~eruptions, opacity:=0.5,
                 fill:="blue", stroke:="black", shape="cross") %>% layer_points()


# bars
pressure %>% ggvis(~temperature, ~pressure) %>% layer_bars()
# map fill property to temperature variable
pressure %>% ggvis(~temperature, ~pressure, fill=~temperature) %>% layer_points()
# map size property to pressure varaible
pressure %>% ggvis(~temperature, ~pressure, size=~pressure) %>% layer_points()

#lines
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()
pressure %>% ggvis(~temperature, ~pressure,
                   stroke:="red", strokeWidth:=2, strokeDash :=6) %>% layer_lines()

# path
pressure %>% ggvis(~temperature, ~pressure, fill:="darkorange") %>% layer_paths()

#### Display model fits
mtcars %>% compute_smooth(mpg~wt)
# returns a new dataframe as output of line fitted to data of orginal data frame
mtcars %>% compute_smooth(mpg~wt) %>% ggvis(~pred_, ~resp_) %>% layer_lines()
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths() %>% layer_points()

#Histograms
faithful %>% ggvis(~waiting) %>% layer_histograms(width=5)

#density plot
faithful %>% ggvis(~waiting, fill:="green") %>% layer_densities()

### ggvis and dplyr
mtcars %>% group_by(am) %>% ggvis(~mpg, ~wt, stroke= ~factor(am)) %>% layer_smooths()
mtcars %>% group_by(cyl) %>% ggvis(~mpg) %>% layer_densities()

# interaction
mtcars %>% group_by(cyl,am) %>% ggvis(~mpg, fill= ~interaction(cyl,am)) %>% layer_densities()


########################### interactive plots ###################################3

### 7 input widgets

#input_checkbox()
#input_checkboxgroup()
#input_numeric()
#input_radiobuttons()
#input_select()
#input_slider()
#input_text()

# select box
faithful %>% ggvis(~waiting, ~eruptions, fillOpacity:=0.5,
                   shape:=input_select(label="Choose shape:",
                                       choices=c("circle","square","cross",
                                                 "diamond","triangle_up",
                                                 "triangle_down")),
                   fill:=input_select(label="Choose color:",
                                      choices=c("black","red","blue","green")))%>%
  layer_points()

# select box that returns variable names
mtcars %>% ggvis(~mpg, ~wt,
                 fill=input_select(label="Choose fill variable:",
                                   choices=names(mtcars), map=as.name)) %>%
  layer_points()


#radio buttons

mtcars %>% ggvis(~mpg, ~wt, fill:=input_radiobuttons(label="Choose colour:",
                                                     choices=c("black","red",
                                                               "blue","green")))%>%
  layer_points()


# text
mtcars %>% ggvis(~mpg, ~wt, fill:=input_text(label="Choose color:",
                                             value="blue"))%>% layer_points()
# you can change the value in the text box to "red", "green" and so on ....



# numeric
mtcars %>% ggvis(~mpg) %>% layer_histograms(width=input_numeric(label="Choose a binwidth:",
                                                              value=1))

# slider
mtcars %>% ggvis(~mpg) %>% layer_histograms(width=input_slider(label="Choose a binwidth:",
                                                              min=1, max=20))

# input select
mtcars %>% ggvis(x=~mpg, y=input_select(label="Choose what to plot:",
                                        choices=names(mtcars),
                                        selected="cyl",
                                        map=as.name))%>%layer_points()


instead of names(mtcars) we can choose:   choices=c('gear'...etc)


# double input select:

mtcars %>% ggvis(x=input_select(label="Choose x-axis to plot:",
                                  choices=names(mtcars),
                                  selected="gear",
                                  map=as.name), 
                y=input_select(label="Choose y-axis to plot:",
                                        choices=names(mtcars),
                                        selected="gear",
                                        map=as.name))%>%layer_points()



##################################### adding layers#####################################3

pressure %>% ggvis(~temperature, ~pressure) %>%
  layer_lines(stroke:="skyblue") %>%
  layer_points(shape:="triangle-up")


pressure %>% ggvis(~temperature, ~pressure) %>%
  layer_lines(opacity := 0.5) %>%
  layer_points() %>%
  layer_model_predictions(model="lm", stroke:="navy")%>%
  layer_smooths(stroke:="skyblue")


##################################### axes and legends #####################################

faithful %>% ggvis(~waiting, ~eruptions)%>% 
  layer_points() %>%
  add_axis("x",
           title="Time since previous eruption(m)",
           values=c(50,60,70,80,90),
           subdivide=9,
           orient="top")%>%
  add_axis("y",
           title="Duration of eruptions(m)",
           values=c(2,3,4,5),
           subdivide=9,
           orient="right")



faithful %>% ggvis(~waiting, ~eruptions, opacity :=0.6,
                   fill=~factor(round(eruptions)))%>%
  layer_points() %>%
  add_legend("fill", title="~duration(m)", orient="left")



faithful %>% ggvis(~waiting ~eruptions, opacity:=0.6,
                   fill=~factor(round(eruptions)), shape=~factor(round(eruptions)),
                   size=~round(eruptions)) %>%
  layer_points()


#### scale types

#scale numeric
mtcars %>%
  ggvis(~wt,~mpg, fill=~disp, stroke=~disp, strokeWidth:=2) %>%
  layer_points()%>%
  scale_numeric("fill", range=c("red","yellow"))%>%
  scale_numeric("stroke", range=c("darkred","orange"))

#scale nominal
mtcars %>% ggvis(~wt,~mpg, fill=~factor(cyl)) %>%
                   layer_points()%>%
                   scale_nominal("fill", range=c("purple","blue", "green"))


# add a scale to limit range of opacity
mtcars %>% ggvis(x=~wt, y=~mpg, fill=~factor(cyl), opacity=~hp) %>%
  layer_points()

# add scale to set domain for x
mtcars %>% ggvis(~wt,~mpg, fill=~disp) %>%
  layer_points() %>%
  scale_numeric("y", domain=c(0, NA))

# add scale to set column color
mtcars %>% ggvis(x=~wt, y=~mpg, fill=~color) %>% 
  layer_points()