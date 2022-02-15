export default function ({ $strapi, redirect }) {
  // If the user is not authenticated
  if (!$strapi.user) {
    return redirect('/')
  }
}
