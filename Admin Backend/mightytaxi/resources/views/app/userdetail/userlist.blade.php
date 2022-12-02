<x-app-layout>
<div class="container-fluid">
         <div class="row">
            <div class="col-lg-12">
               <div class="card card-block card-stretch card-height">
                  <div class="card-header d-flex justify-content-between">
                     <div class="header-title">
                        <h4 class="card-title mb-0">User List</h4>
                     </div>
                     <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#addContact">Add New</a>
                  </div>
                  <div class="card-body">
                     <div class="table-responsive">
                        <table class="data-tables table" style="width:100%">
                           <thead class="light">
                              <tr>
                                 <th>Profile</th>
                                 <th>Name</th>
                                 <th>Email</th>
                                 <th>Phone No.</th>
                                 <th>Action</th>
                              </tr>
                           </thead>
                           <tbody>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/1.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>John Doe</td>
                                 <td>Johndoe@gmail.com</td>
                                 <td>+55 2598 256 890</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/2.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Bill Dabear</td>
                                 <td>billdabear@gmail.com</td>
                                 <td>+55 2563 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/3.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Marge Arita</td>
                                 <td>margearita@gmail.com</td>
                                 <td>+27 5625 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/7.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>aaronottix</td>
                                 <td>budwiser@ymail.com</td>
                                 <td>(760) 765 2658</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/6.jpg")}}  class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Eric Shun</td>
                                 <td>ericshun@gmail.com</td>
                                 <td>+55 2568 256 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/5.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Lynn Guini</td>
                                 <td>lynnguini@gmail.com</td>
                                 <td>+27 2563 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/4.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Hans Olo</td>
                                 <td>hansolo@gmail.com</td>
                                 <td>+91 2586 253 125</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/3.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Dan Druff</td>
                                 <td>dandruff@gmail.com</td>
                                 <td>+55 6523 456 856</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/2.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Brock Lee</td>
                                 <td>brocklee@gmail.com</td>
                                 <td>+62 5689 458 658</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/1.jpg")}}  class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Anna Sthesia</td>
                                 <td>annasthesia@gmail.com</td>
                                 <td>(760) 756 7568</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Rating"
                                          href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                             href="#">
                                             <div class="dropdown">
                                                <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown" aria-haspopup="true"
                                                   aria-expanded="false" href="#">
                                                   
                                                </span>
                                                <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                   <a class="dropdown-item" href="#">Edit</a>
                                                   <a class="dropdown-item" href="#">Delete</a>
                                                   <a class="dropdown-item" href="#">Hide from Contacts</a>
                                                </div>
                                             </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/1.jpg")}}  class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Anna Sthesia</td>
                                 <td>annasthesia@gmail.com</td>
                                 <td>(760) 756 7568</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Rating"
                                          href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                             href="#">
                                             <div class="dropdown">
                                                <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown" aria-haspopup="true"
                                                   aria-expanded="false" href="#">
                                                   
                                                </span>
                                                <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                   <a class="dropdown-item" href="#">Edit</a>
                                                   <a class="dropdown-item" href="#">Delete</a>
                                                   <a class="dropdown-item" href="#">Hide from Contacts</a>
                                                </div>
                                             </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/2.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Brock Lee</td>
                                 <td>brocklee@gmail.com</td>
                                 <td>+62 5689 458 658</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/3.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Dan Druff</td>
                                 <td>dandruff@gmail.com</td>
                                 <td>+55 6523 456 856</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/4.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Hans Olo</td>
                                 <td>hansolo@gmail.com</td>
                                 <td>+91 2586 253 125</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/5.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Lynn Guini</td>
                                 <td>lynnguini@gmail.com</td>
                                 <td>+27 2563 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/6.jpg")}}  class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Eric Shun</td>
                                 <td>ericshun@gmail.com</td>
                                 <td>+55 2568 256 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/7.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>aaronottix</td>
                                 <td>budwiser@ymail.com</td>
                                 <td>(760) 765 2658</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/3.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Marge Arita</td>
                                 <td>margearita@gmail.com</td>
                                 <td>+27 5625 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/2.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Bill Dabear</td>
                                 <td>billdabear@gmail.com</td>
                                 <td>+55 2563 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/1.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>John Doe</td>
                                 <td>Johndoe@gmail.com</td>
                                 <td>+55 2598 256 890</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/1.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>John Doe</td>
                                 <td>Johndoe@gmail.com</td>
                                 <td>+55 2598 256 890</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/2.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Bill Dabear</td>
                                 <td>billdabear@gmail.com</td>
                                 <td>+55 2563 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/3.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Marge Arita</td>
                                 <td>margearita@gmail.com</td>
                                 <td>+27 5625 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/7.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>aaronottix</td>
                                 <td>budwiser@ymail.com</td>
                                 <td>(760) 765 2658</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/6.jpg")}}  class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Eric Shun</td>
                                 <td>ericshun@gmail.com</td>
                                 <td>+55 2568 256 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/5.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Lynn Guini</td>
                                 <td>lynnguini@gmail.com</td>
                                 <td>+27 2563 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/4.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Hans Olo</td>
                                 <td>hansolo@gmail.com</td>
                                 <td>+91 2586 253 125</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/3.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Dan Druff</td>
                                 <td>dandruff@gmail.com</td>
                                 <td>+55 6523 456 856</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/2.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Brock Lee</td>
                                 <td>brocklee@gmail.com</td>
                                 <td>+62 5689 458 658</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/1.jpg")}}  class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Anna Sthesia</td>
                                 <td>annasthesia@gmail.com</td>
                                 <td>(760) 756 7568</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Rating"
                                          href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                             href="#">
                                             <div class="dropdown">
                                                <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown" aria-haspopup="true"
                                                   aria-expanded="false" href="#">
                                                   
                                                </span>
                                                <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                   <a class="dropdown-item" href="#">Edit</a>
                                                   <a class="dropdown-item" href="#">Delete</a>
                                                   <a class="dropdown-item" href="#">Hide from Contacts</a>
                                                </div>
                                             </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/1.jpg")}}  class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Anna Sthesia</td>
                                 <td>annasthesia@gmail.com</td>
                                 <td>(760) 756 7568</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Rating"
                                          href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                             href="#">
                                             <div class="dropdown">
                                                <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown" aria-haspopup="true"
                                                   aria-expanded="false" href="#">
                                                   
                                                </span>
                                                <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                   <a class="dropdown-item" href="#">Edit</a>
                                                   <a class="dropdown-item" href="#">Delete</a>
                                                   <a class="dropdown-item" href="#">Hide from Contacts</a>
                                                </div>
                                             </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/2.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Brock Lee</td>
                                 <td>brocklee@gmail.com</td>
                                 <td>+62 5689 458 658</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/3.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Dan Druff</td>
                                 <td>dandruff@gmail.com</td>
                                 <td>+55 6523 456 856</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/4.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Hans Olo</td>
                                 <td>hansolo@gmail.com</td>
                                 <td>+91 2586 253 125</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/5.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Lynn Guini</td>
                                 <td>lynnguini@gmail.com</td>
                                 <td>+27 2563 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/6.jpg")}}  class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Eric Shun</td>
                                 <td>ericshun@gmail.com</td>
                                 <td>+55 2568 256 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/7.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>aaronottix</td>
                                 <td>budwiser@ymail.com</td>
                                 <td>(760) 765 2658</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/3.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Marge Arita</td>
                                 <td>margearita@gmail.com</td>
                                 <td>+27 5625 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/2.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>Bill Dabear</td>
                                 <td>billdabear@gmail.com</td>
                                 <td>+55 2563 456 589</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <img src={{URL::asset("images/user/1.jpg")}} class="rounded avatar-40 img-fluid" alt="">
                                 </td>
                                 <td>John Doe</td>
                                 <td>Johndoe@gmail.com</td>
                                 <td>+55 2598 256 890</td>
                                 <td>
                                    <div class="d-flex align-items-center list-action">
                                       <a class="badge bg-warning-light mr-2" data-toggle="tooltip" data-placement="top" title=""
                                          data-original-title="Rating" href="#"><i class="far fa-star"></i></a>
                                       <a class="badge bg-success-light mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"
                                          href="#"><i class="lar la-eye"></i></a>
                                       <span class="badge bg-primary-light" data-toggle="tooltip" data-placement="top" title="" data-original-title="Action"
                                          href="#">
                                          <div class="dropdown">
                                             <span class="text-primary dropdown-toggle action-item" id="moreOptions1" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" href="#">
                                    
                                             </span>
                                             <div class="dropdown-menu" aria-labelledby="moreOptions1">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Hide from Contacts</a>
                                             </div>
                                          </div>
                                       </span>
                                    </div>
                                 </td>
                              </tr>
                           </tbody>
                        </table>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      </div>
    </div> 
</x-app-layout>