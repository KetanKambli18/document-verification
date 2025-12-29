import axios from "axios";
const PINATA_API_KEY = process.env.REACT_PINATA_API_KEY;
const PINATA_SECRET = process.env.REACT_PINATA_SECRET_KEY;

export const uploadToIPFS = async (file) => {
    const data = new FormData();
    data.append("file",file);

    const res = await axios.post(
        "https://api.pinata.cloud/pinning/pinFileToIPFS",
        data,
        {
            headers:{
                pinata_api_key: PINATA_API_KEY,
                pinata_secret_key: PINATA_SECRET,
            },
        }
    );

    return res.data.IpfsHash; 
};

