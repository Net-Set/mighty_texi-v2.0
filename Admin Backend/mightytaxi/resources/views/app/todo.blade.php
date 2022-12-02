<x-app-layout>
   <div class="container-fluid">
         <div class="row">
            <div class="col-md-12">
               <div class="card">
                  <div class="card-header d-flex justify-content-between border-bottom-0">
                     <div class="header-title">
                        <h4 class="card-title">Todo</h4>
                     </div>
                     <div class="header-action">
                        <div class="btn-group btn-group-sm" role="group" aria-label="Basic example">
                           <button type="button" class="btn btn-outline-primary active" data-toggle-extra="tab" data-target-extra="#board-content">Board</button>
                           <button type="button" class="btn btn-outline-primary" data-toggle-extra="tab" data-target-extra="#list-content">List</button>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-md-12">
               <div id="board-content" class="animate__animated animate__fadeIn active" data-toggle-extra="tab-content">
                  <div class="board-content">
                     <div class="board-item">
                        <div class="card">
                           <div class="card-body">
                              <h5 class="item-title">Todo</h5>
                           </div>
                        </div>
                        <div class="board-scrollbar board-scrollbar-0">
                           <x-todo-board-card id='1' title='Launch SpaceX' class="border-color-left-blue"></x-todo-board-card>
                           <x-todo-board-card id='2' title='New Updates' class="border-color-left-red"></x-todo-board-card>
                           <x-todo-board-card id='3' title='Night mode' class="border-color-left-yellow"></x-todo-board-card>
                           <x-todo-board-card id='4' title='Use-cases' class="border-color-left-green"></x-todo-board-card>
                           <x-todo-board-card id='5' title='Five Task' ></x-todo-board-card>    
                        </div>
                     </div>
                     <div class="board-item">
                        <div class="card">
                           <div class="card-body">
                              <h5 class="item-title">In Progress</h5>
                           </div>
                        </div>
                        <div class="board-scrollbar board-scrollbar-1">
                           <x-todo-board-card id='7' title='New Updates' class=""></x-todo-board-card>
                           <x-todo-board-card id='6' title='Launch SpaceX' class="border-color-left-yellow"></x-todo-board-card>
                           <x-todo-board-card id='9' title='Use-cases' class="border-color-left-red"></x-todo-board-card>
                           <x-todo-board-card id='8' title='Night mode' class="border-color-left-blue"></x-todo-board-card>
                           <x-todo-board-card id='10' title='Five Task'></x-todo-board-card>
                           
                        </div>
                     </div>
                     <div class="board-item">
                        <div class="card">
                           <div class="card-body">
                              <h5 class="item-title">Review</h5>
                           </div>
                        </div>
                        <div class="board-scrollbar board-scrollbar-2">
                           <x-todo-board-card id='13' title='Night mode' class="border-color-left-red" ></x-todo-board-card>
                           <x-todo-board-card id='11' title='Launch SpaceX' class="border-color-left-blue" ></x-todo-board-card>
                           <x-todo-board-card id='14' title='Use-cases' class="border-color-left-green" ></x-todo-board-card>
                           <x-todo-board-card id='12' title='New Updates' class=""></x-todo-board-card>
                           <x-todo-board-card id='15' title='Five Task'></x-todo-board-card>
                        </div>
                     </div>
                     <div class="board-item">
                        <div class="card">
                           <div class="card-body">
                              <h5 class="item-title">Complete</h5>
                           </div>
                        </div>
                        <div class="board-scrollbar board-scrollbar-3">
                           <x-todo-board-card id='16' title='Launch SpaceX' class="border-color-left-blue"></x-todo-board-card>
                           <x-todo-board-card id='17' title='New Updates' class="border-color-left-red"></x-todo-board-card>
                           <x-todo-board-card id='18' title='Night mode' class="border-color-left-yellow"></x-todo-board-card>
                           <x-todo-board-card id='19' title='Use-cases' class="border-color-left-green"></x-todo-board-card>
                           <x-todo-board-card id='19' title='Use-cases' class="border-color-left-green"></x-todo-board-card>
                           
                        </div>
                     </div>
                  </div>
               </div>
               <div id="list-content" class="animate__animated animate__fadeIn" data-toggle-extra="tab-content">
                  <div class="list-content">
                     <div class="list-item">
                        <div class="card">
                           <div class="card-body">
                              <h5 class="item-title">Todo</h5>
                           </div>
                        </div>
                        <x-todo-list-card id='1' title='Launch SpaceX' class="border-color-left-blue"></x-todo-list-card>
                        <x-todo-list-card id='2' title='New Updates' class="border-color-left-red"></x-todo-list-card>
                        <x-todo-list-card id='3' title='Night mode' class="border-color-left-yellow"></x-todo-list-card>
                        <x-todo-list-card id='4' title='Use-cases' class="border-color-left-green"></x-todo-list-card>
                        <x-todo-list-card id='5' title='Five Task' class=""></x-todo-list-card>
                     </div>
                     <div class="list-item">
                        <div class="card">
                           <div class="card-body">
                              <h5 class="item-title">In Progress</h5>
                           </div>
                        </div>
                        <x-todo-list-card id='6' title='Launch SpaceX' class="border-color-left-blue" ></x-todo-list-card>
                        <x-todo-list-card id='7' title='New Updates' class="border-color-left-red"></x-todo-list-card>
                        <x-todo-list-card id='8' title='Night mode' class="border-color-left-yellow"></x-todo-list-card>
                        <x-todo-list-card id='9' title='Use-cases' class="border-color-left-green" ></x-todo-list-card>
                        <x-todo-list-card id='10' title='Five Task' class="" ></x-todo-list-card>
                     </div>
                     <div class="list-item">
                        <div class="card">
                           <div class="card-body">
                              <h5 class="item-title">Review</h5>
                           </div>
                        </div>
                        <x-todo-list-card id='6' title='Launch SpaceX' class="border-color-left-blue" ></x-todo-list-card>
                        <x-todo-list-card id='7' title='New Updates' class="border-color-left-red"></x-todo-list-card>
                        <x-todo-list-card id='8' title='Night mode' class="border-color-left-yellow"></x-todo-list-card>
                        <x-todo-list-card id='9' title='Use-cases' class="border-color-left-green" ></x-todo-list-card>
                        <x-todo-list-card id='10' title='Five Task' class="" ></x-todo-list-card>
                     </div>
                     <div class="list-item">
                        <div class="card">
                           <div class="card-body">
                              <h5 class="item-title">Complete</h5>
                           </div>
                        </div>
                        <x-todo-list-card id='16' title='Launch SpaceX' class="border-color-left-blue"  ></x-todo-list-card>
                        <x-todo-list-card id='17' title='New Updates' class="border-color-left-red"  ></x-todo-list-card>
                        <x-todo-list-card id='18' title='Night mode' class="border-color-left-yellow" ></x-todo-list-card>
                        <x-todo-list-card id='19' title='Use-cases' class="border-color-left-green"  ></x-todo-list-card>
                        <x-todo-list-card id='20' title='Five Task' class='' ></x-todo-list-card>
                     </div>
               </div>
            </div>
         </div>
     </div>
     </div>
</x-app-layout>
