import { useHistory, useParams } from "react-router-dom";
import { addComment, getItem } from "../application/shop";
import { useEffect, useState } from "react";
import NavBar from "../../../components/NavBar";
import Loading from "../../../components/Loading";
import Rating from "react-rating";
import "@fortawesome/fontawesome-free/css/all.css";

import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
function ItemDetail() {
  const { id } = useParams();
  const [item, setItem] = useState({});
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    getItem(id).then((item) => {
      setLoading(false);
      setItem(item);
    });

    return () => {
      // Cleanup
    };
  }, []);

  return (
    <>
      <NavBar />
      {loading ? <Loading /> : <LoadedPage item={item} />}
    </>
  );
}

function LoadedPage({ item }) {
  const [comment, setComment] = useState("");
    const history = useHistory();





  return (
    <>
      <section className="mt-[8vh] min-h-[52vh] w-[100%] p-6 lg:p-12 ">
        <div className="flex flex-col lg:flex-row">
          <img
            className="object-cover h-[100%] w-[100%] lg:w-[40vw] bg-white border-slate-300 rounded-md border-2 p-4 border-dashed"
            src={item.images[0]}
            alt=""
          />
          <div className="flex flex-col pl-8 mt-5 lg:mt-0">
            <h1 className="pb-2 text-5xl font-bold">{item.name}</h1>
            <div className="flex flex-row items-end">
              <h1 className="pb-5 mr-3 text-3xl font-light line-through text-gray-300">
                {"$ " + (parseFloat(item.price) + 20)}
              </h1>

              <h1 className="pb-5 text-4xl font-bold text-accentColor">
                {"$ " + item.price}
              </h1>
            </div>

            <div className="flex flex-row gap-4 mb-2">
              <Rating
                initialRating={4.0}
                fullSymbol="fa-solid fa-star text-2xl text-amber-400 "
                emptySymbol="fa-regular fa-star text-2xl text-gray-300"
              />
              <h1 className="text-slate-500">4.5 out of 5</h1>
            </div>
            <p className="text-lg">{item.description}</p>
          </div>
        </div>
      </section>
      {/* Comments Section */}

      <h1 className="text-3xl font-bold pl-12 ">User Reviews</h1>
      <div className="flex flex-col md:flex-row mt-5   h-[8vh] mx-5 md:mx-12">
        <input
          onChange={(e) => {
            setComment(e.target.value);
          }}
          type="text"
          placeholder="Enter your review"
          className="bg-semiDarkColor bg-opacity-10 flex-1 py-5 md:mr-5  border-2 outline-none border-white focus:border-darkColor focus:rounded-lg focus:outline-none px-2 transition-all "
        ></input>
        <button
          className="mt-5 md:mt-0 px-5 text-white rounded-md bg-accentColor"
          onClick={async () => {
            var res = await addComment({ comment: comment, itemID: item._id });
            if (res) {
              window.location.reload();
            } else {
              history.push("/");
            }
          }}
        >
          Comment
        </button>
      </div>

      {item.comments.length > 0 && (
        <section className="px-5 md:px-12 mb-5 md:mb-12">
          {item.comments.map((comment) => (
            // <p key={comment._id}>{comment.content}</p>
            <div
              key={comment._id}
              className="flex flex-row pt-4 pb-2 border-b border-slate-200"
            >
              <div className="h-[25px] w-[25px] text-white p-4 rounded-full bg-lightColor flex justify-center items-center">
                <p className="">{comment.name[0]}</p>
              </div>
              <div className="flex flex-col pl-2">
                <h1 className="text-xl">{comment.content}</h1>
                <p className="text-slate-400">{comment.name}</p>
              </div>
            </div>
          ))}
        </section>
      )}
    </>
  );
}

export default ItemDetail;
