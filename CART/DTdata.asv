function [train test targets] = DTdata()
attribute = {'outlook' 'temperature' 'humidity' 'wind' 'playtennis'}';
train = {'sunny' 'hot' 'high' 'weak' 'no';
         'sunny' 'hot' 'high' 'strong' 'no';
         'overcast' 'hot' 'high' 'weak' 'yes';
         'rain' 'mild' 'high' 'weak' 'yes';
         'rain' 'cool' 'normal' 'weak' 'yes';
         'rain' 'cool' 'normal' 'strong' 'no';
         'overcast' 'cool' 'normal' 'strong' 'yes';
         'sunny' 'mild' 'high' 'weak' 'no';
         'sunny' 'cool' 'normal' 'weak' 'yes';
         'rain' 'mild' 'normal' 'weak' 'yes';
         'sunny' 'mild' 'normal' 'strong' 'yes';
         'overcast' 'mild' 'high' 'strong' 'yes';
         'overcast' 'hot' 'normal' 'weak' 'yes';
         'rain' 'mild' 'high' 'strong' 'no';}';
test = { 'rain' 'cool' 'high' 'strong'}';
targets = {'no' 'no' 'yes' 'yes' 'yes' 'no' 'yes' 'no' 'yes' 'yes' 'yes' 'yes' 'yes' 'no'};


train = [1 1 1 2 2 2 3 3 3 3;5 5 5 5 5 6 6 6 6 6;10.2 12 14 16 18 20 22 23 24 25];
targets = [1 0 1 0 1 0 1 0 1 0];
test = [3 1 2 1 2 3 3;6 6 6 5 5 4 4;20 26 26 13 23 11 10];
