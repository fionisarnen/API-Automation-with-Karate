function generateRandomName(length) {
     if (typeof length !== 'number' || length <= 0) {
         console.error("Invalid length provided. Defaulting to 10.");
         length = 10;
     }

     const characters = 'abcdefghijklmnopqrstuvwxyz';
     let result = '';
     for (let i = 0; i < length; i++) {
         // Generate a random index within the character set
         const randomIndex = Math.floor(Math.random() * characters.length);

         // Append the character at that index to the result
         result += characters.charAt(randomIndex);
     }
     return result;
 }