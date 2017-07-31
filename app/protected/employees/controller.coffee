import Ember from 'ember'
import pagedArray from 'ember-cli-pagination/computed/paged-array'
import ApplicationController from '../../application/controller'

EmployeesController = ApplicationController.extend
    protected: Ember.inject.controller()
    
    user: Ember.computed.reads 'protected.user'
    
    employees: Ember.computed.reads 'protected.employees'
    
    queryParams: ['employeespage', 'employeesperPage']
    
    employeespage: 1
    employeesperPage: 10
    
    pagedEmployees: pagedArray 'employees',
        page: Ember.computed.alias 'parent.employeespage'
        perPage: Ember.computed.alias 'parent.employeesperPage'
        
    totalPages: Ember.computed.oneWay 'pagedEmployees.totalPages'
    
export default EmployeesController
