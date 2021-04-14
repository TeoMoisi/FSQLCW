/*
 * generated by Xtext 2.25.0
 */
package uk.ac.kcl.language.fsql.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import uk.ac.kcl.language.fsql.fSQL.FSQL
import uk.ac.kcl.language.fsql.fSQL.DatabaseStatements
import uk.ac.kcl.language.fsql.fSQL.CreateDB
import uk.ac.kcl.language.fsql.fSQL.UseDB
import uk.ac.kcl.language.fsql.fSQL.TableStatements
import uk.ac.kcl.language.fsql.fSQL.CreateTable
import uk.ac.kcl.language.fsql.fSQL.InitTable
import uk.ac.kcl.language.fsql.fSQL.SchemaDeclaration
import uk.ac.kcl.language.fsql.fSQL.ColumnDeclaration
import uk.ac.kcl.language.fsql.fSQL.SimpleDeclaration
import uk.ac.kcl.language.fsql.fSQL.PrimaryKey
import uk.ac.kcl.language.fsql.fSQL.ColumnType
import uk.ac.kcl.language.fsql.fSQL.ForeignKey
import uk.ac.kcl.language.fsql.fSQL.CompositeKey
import uk.ac.kcl.language.fsql.fSQL.ColumnNameReference
import uk.ac.kcl.language.fsql.fSQL.TableStatement
import uk.ac.kcl.language.fsql.fSQL.DropTable
import uk.ac.kcl.language.fsql.fSQL.AddRow
import uk.ac.kcl.language.fsql.fSQL.RowDeclaration
import uk.ac.kcl.language.fsql.fSQL.AssignColumnValue
import uk.ac.kcl.language.fsql.fSQL.AddRows
import uk.ac.kcl.language.fsql.fSQL.Delete
import uk.ac.kcl.language.fsql.fSQL.WhereClause
import uk.ac.kcl.language.fsql.fSQL.Condition
import uk.ac.kcl.language.fsql.fSQL.ConditionOperator
import uk.ac.kcl.language.fsql.fSQL.Operator
import uk.ac.kcl.language.fsql.fSQL.ConditionalOperator
import uk.ac.kcl.language.fsql.fSQL.Update
import uk.ac.kcl.language.fsql.fSQL.AlterTable
import uk.ac.kcl.language.fsql.fSQL.AddColumn
import uk.ac.kcl.language.fsql.fSQL.AddColumns
import uk.ac.kcl.language.fsql.fSQL.DropColumn
import uk.ac.kcl.language.fsql.fSQL.DropColumns
import uk.ac.kcl.language.fsql.fSQL.ModifyColumns
import uk.ac.kcl.language.fsql.fSQL.Join
import uk.ac.kcl.language.fsql.fSQL.SelectStatement
import uk.ac.kcl.language.fsql.fSQL.Select
import uk.ac.kcl.language.fsql.fSQL.CollectionSelect
import uk.ac.kcl.language.fsql.fSQL.AggregatedSelect
import uk.ac.kcl.language.fsql.fSQL.Aggregation
import uk.ac.kcl.language.fsql.fSQL.GroupedSelect
import uk.ac.kcl.language.fsql.fSQL.GroupByStmt
import uk.ac.kcl.language.fsql.fSQL.HavingStmt
import uk.ac.kcl.language.fsql.fSQL.SortedSelect
import uk.ac.kcl.language.fsql.fSQL.OrderByStmt
import uk.ac.kcl.language.fsql.fSQL.SortingOrder
import uk.ac.kcl.language.fsql.fSQL.GroupSortedSelect
import uk.ac.kcl.language.fsql.fSQL.Query
import uk.ac.kcl.language.fsql.fSQL.JoinType
import uk.ac.kcl.language.fsql.fSQL.TableColumnsCondition
import uk.ac.kcl.language.fsql.fSQL.SelectAll

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class FSQLGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		val model = resource.contents.head as FSQL
		
		val className = resource.deriveClassNameFor
		
		fsa.generateFile(className + '.sql', model.doGenerateCode)
	}
	
	def deriveClassNameFor(Resource resource) {
		val origName = resource.URI.lastSegment

		origName.substring(0, origName.indexOf('.'))
	}
	
	def String doGenerateCode(FSQL program) '''
		«program.dbStatements.map[generateSQLDBCommand].join('\n')»
		«program.tableStatements.map[generateSQLTableCommand].join('\n')»
	'''
	
	dispatch def String generateSQLDBCommand(DatabaseStatements dbStmt) '''
	'''
	
	dispatch def String generateSQLDBCommand(CreateDB createDB) '''
		CREATE DATABASE «createDB.getName»;
	'''
	
	dispatch def String generateSQLDBCommand(UseDB useDB) '''
		USE «useDB.getDatabase().^var.name»;
	'''
	
	dispatch def String generateSQLTableCommand(TableStatements tableStmt)'''
	'''
	
	dispatch def String generateSQLTableCommand(CreateTable createTable)'''
	'''
	
	dispatch def String generateSQLTableCommand(InitTable initTable)'''
	'''
	
	dispatch def String generateSQLTableCommand(TableStatement tableStmt)'''
	'''
	
	dispatch def String generateSQLTableCommand(DropTable command)'''
		DROP TABLE «command.table.^var.name»;
	'''
	
	dispatch def String generateSQLTableCommand(SchemaDeclaration schema)'''
		CREATE TABLE «schema.table.get(0).^var.name»(
			«schema.column.map[generateSQLColumns].join('') + if (schema.columns !== null) {','}»
			«if (schema.columns !== null) {schema.columns.map[generateSQLColumns].join(',\n')}»
		);'''
	
	// this will generate SQL code for each column declaration
	dispatch def String generateSQLColumns(ColumnDeclaration column)''''''
	
	dispatch def String generateSQLColumns(SimpleDeclaration column)'''«column.getName» «if (column.type === ColumnType.BOOL) {'''BOOLEAN'''} else if (column.type === ColumnType.STRING) {'''VARCHAR(255)'''} else {column.type}»'''
	
	dispatch def String generateSQLColumns(PrimaryKey column)'''«column.column.generateSQLColumns» PRIMARY KEY'''
	
	dispatch def String generateSQLColumns(ForeignKey column)'''FOREIGN KEY («column.getColumn().generateSQLColumnNameReference») REFERENCES «column.table.get(0).^var.name»(«column.getColumn().generateSQLColumnNameReference»)'''
	
	dispatch def String generateSQLColumns(CompositeKey column)'''PRIMARY KEY («column.getColumn().generateSQLColumnNameReference»«',' + column.getColumns().map[generateSQLColumnNameReference].join(',')»)'''
	
	def String generateSQLColumnNameReference(ColumnNameReference columnRef) '''«if (columnRef.table !== null) {columnRef.table.^var.name + '.'}»«columnRef.^var.generateSQLColumns.split(' ').get(0)»'''
	
	dispatch def String generateSQLTableCommand(AddRow command)'''INSERT INTO «command.table.get(0).^var.name» («command.row.map[generateRowDeclaration].join('')»);'''
	
	dispatch def String generateSQLTableCommand(AddRows command)'''INSERT INTO «command.table.get(0).^var.name» («command.row.generateRowDeclaration»)«command.rows.map[generateMultipleRows].join('')»;'''
	
	def String generateAssignColumnName(AssignColumnValue assignColumn)'''
	«assignColumn.column.generateSQLColumnNameReference»'''
	
	def String generateAssignColumnValue(AssignColumnValue assignColumn)'''
	«if (assignColumn.value.toString().contains("String")) {
		'"' + assignColumn.value.toString().split('val: ').get(1).substring(0, assignColumn.value.toString().split('val: ').get(1).length - 1) + '"'
	} else {
		assignColumn.value.toString().split('val: ').get(1).substring(0, assignColumn.value.toString().split('val: ').get(1).length - 1)
	}»'''
	
	def String generateAssignColumn(AssignColumnValue assignColumn)'''
	«assignColumn.generateAssignColumnName»=«assignColumn.generateAssignColumnValue»'''
	
	
	def String generateRowDeclaration(RowDeclaration row)'''«row.column.generateAssignColumnName»«',' + row.columns.map[generateAssignColumnName].join(',')») VALUES («row.column.generateAssignColumnValue»«',' + row.columns.map[generateAssignColumnValue].join(',')»'''
	
	def String generateMultipleRows(RowDeclaration row) ''', («row.column.generateAssignColumnValue»«',' + row.columns.map[generateAssignColumnValue].join(',')»)'''
	
	dispatch def String generateSQLTableCommand(Delete deleteCommand)'''
	«if (deleteCommand.whereClause === null) 
		{'DELETE * FROM '+ deleteCommand.table.get(0).^var.name} 
	else
		{ 'DELETE FROM ' + deleteCommand.table.get(0).^var.name + ' ' + deleteCommand.whereClause.generateWhereClause}
	»;'''
	
	def String generateWhereClause(WhereClause whereClause)'''
	 WHERE «whereClause.query.get(0).generateQuery»
	 «if (whereClause.cond !== null) {
	 	whereClause.cond.map[generateOperatorWithCondition].join('')
	 }»
	 '''
	 
	def String generateOperatorWithCondition(ConditionalOperator cond)'''«cond.operator.generateOperatorValue»«cond.queries.generateQuery»'''
	 
	def String generateOperatorValue(Operator op) '''«
		if (op == Operator.AND) {
			' AND '
		} else {
			' OR '
		}»'''
	
	def String generateQuery(Condition condition)'''
		«condition.getColumn().generateSQLColumnNameReference»«condition.getCondition().generateConditionValue»
		«if (condition.getValue().toString().contains("String")) {
			'"' + condition.getValue().toString().split(' ').get(2).substring(0, condition.getValue().toString().split(' ').get(2).length - 1) + '"'
		} else {
			condition.getValue().toString().split(' ').get(2).substring(0, condition.getValue().toString().split(' ').get(2).length - 1)
		}»'''
	
	def String generateConditionValue(ConditionOperator cond)'''
	«if (cond == ConditionOperator.LT) 
		{'<'} 
	 else if (cond == ConditionOperator.GT)
	 	{'>'}
	 else if (cond == ConditionOperator.EQ)
	 	{'='}
	 else if (cond == ConditionOperator.LTE)
	 	{'<='}
	 else if (cond == ConditionOperator.GTE)
	 	{'>='}
	 else
	 	{'!='}
	 »'''
	 
	 dispatch def String generateSQLTableCommand(Update updateCommand)'''
	 UPDATE «updateCommand.table.get(0).^var.name»
	 SET «updateCommand.column.generateAssignColumn»
	 «if (updateCommand.columns !== null) {',' + updateCommand.columns.map[generateAssignColumn].join(',')}»
	 «if (updateCommand.whereClause !== null) {
	 	updateCommand.whereClause.generateWhereClause
	 }»;'''
	 
	 dispatch def String generateSQLTableCommand(AlterTable alterCommand)''''''
	 
	 dispatch def String generateSQLTableCommand(AddColumn addColumn)'''
	 ALTER TABLE «addColumn.table.get(0).^var.name»
	 ADD «addColumn.column.map[generateSQLColumns].join('')»;
	 '''
	 
	 dispatch def String generateSQLTableCommand(AddColumns addColumns)'''
	 ALTER TABLE «addColumns.table.get(0).^var.name»
	 ADD («addColumns.column.map[generateSQLColumns].join('')»«',' + addColumns.columns.map[generateSQLColumns].join(',')»);
	 '''
	 
	 dispatch def String generateSQLTableCommand(DropColumn dropColumn)'''
	 ALTER TABLE «dropColumn.table.get(0).^var.name»
	 DROP COLUMN «dropColumn.col.generateSQLColumnNameReference»;
	 '''
	 
	 dispatch def String generateSQLTableCommand(DropColumns dropColumns)'''
	 ALTER TABLE «dropColumns.table.get(0).^var.name»
	 DROP COLUMN («dropColumns.column.generateSQLColumnNameReference»«',' + dropColumns.columns.map[generateSQLColumnNameReference].join(',')»);
	 '''
	 
	 dispatch def String generateSQLTableCommand(ModifyColumns modifyColumns)'''
	 ALTER TABLE «modifyColumns.table.get(0).^var.name»
	 MODIFY «if (modifyColumns.columns !== null) {'(' + modifyColumns.column.generateSQLColumns +',' + modifyColumns.columns.map[generateSQLColumns].join(',') + ')'}
	 else {modifyColumns.column.generateSQLColumns}»;
	 '''
	 
	 dispatch def String generateSQLTableCommand(SelectStatement selectStmt)'''
	 «selectStmt.select.generateSelect(selectStmt.table.^var.name.toString())»;
	 '''
	 
	 dispatch def String generateSelect(Select select, String table)''''''
	 
	 dispatch def String generateSelect(SelectAll select, String table)'''
	 SELECT * FROM «table»'''
	 
	 dispatch def String generateSelect(CollectionSelect select, String table)'''
	 SELECT «select.column.generateSQLColumnNameReference»
	 «if (!select.columns.empty) {
	 	',' + select.columns.map[generateSQLColumnNameReference].join(',')
	 }» FROM «table»'''
	 
	 dispatch def String generateSelect(AggregatedSelect select, String table)'''
	 SELECT «select.aggregation.generateAggregation»(«select.select.column.generateSQLColumnNameReference») FROM «table»'''
	 
	 def String generateAggregation(Aggregation aggregation)'''
	 «if (aggregation.aggregation.toString() == 'max()') {
	 	'MAX'
	 } else if (aggregation.aggregation.toString() == 'min()') { 
	 	'MIN'
	 } else if (aggregation.aggregation.toString() == 'count()') {
	 	'COUNT'
	 } else if (aggregation.aggregation.toString() == 'sum()'){
	 	'SUM'
	 } else {
	 	'AVG'
	 }»'''
	 
	 dispatch def String generateSelect(GroupedSelect select, String table)'''
	 «select.select.generateSelect(table)» «select.groupBy.generateGroupBy»'''
	 
	 def String generateGroupBy(GroupByStmt groupStmt)'''
	 «if (groupStmt.method.toString() == 'groupBy') {
	 'GROUP BY' + ' ' + groupStmt.column.generateSQLColumnNameReference
	 }»
	 «if (groupStmt.having !== null) {
	 	groupStmt.having.generateHavingStmt
	 }»'''
	 
	 def String generateHavingStmt(HavingStmt havingStmt)'''
	 «if (havingStmt.method.toString() == 'having') {
	 	 'HAVING' + ' ' + havingStmt.query.map[generateQuery].join('')
	 	 }»
	 '''
	 
	 dispatch def String generateSelect(SortedSelect select, String table)'''
	 «select.select.generateSelect(table)» «select.orderBy.generateOrderBy»'''
	 
	 def String generateOrderBy(OrderByStmt orderStmt)'''
	 «if (orderStmt.method.toString() == 'orderBy') {
	 'ORDER BY' + ' ' + orderStmt.column.generateSQLColumnNameReference
	 }»
	 «if (orderStmt.order !== null) {
	 	orderStmt.order.generateOrder
	 }»'''
	 
	 def String generateOrder(SortingOrder order)'''
	 «if (order == SortingOrder.ASC) {
	 	'ASC'
	 } else {
	 	'DESC'
	 }»
	 '''
	 
	 dispatch def String generateSelect(GroupSortedSelect select, String table)'''
	 «select.select.generateSelect(table)» «select.groupBy.generateGroupBy» «select.orderBy.generateOrderBy»'''
	 
	 dispatch def String generateSQLTableCommand(Query query)'''
	 «query.select.generateQuerySelect(query.table.^var.name.toString(), query.whereClause)»
	 '''
	 
	 dispatch def String generateQuerySelect(Select select, String table, WhereClause whereClause)''''''
	 
	 dispatch def String generateQuerySelect(SelectAll select, String table, WhereClause whereClause)'''
	 SELECT * FROM «table» «whereClause.generateWhereClause»;'''
	 
	 dispatch def String generateQuerySelect(CollectionSelect select, String table, WhereClause whereClause)'''
	 SELECT «select.column.generateSQLColumnNameReference»
	 «if (!select.columns.empty) {
	 	',' + select.columns.map[generateSQLColumnNameReference].join(',')
	 }» FROM «table» «whereClause.generateWhereClause»'''
	 
	 dispatch def String generateQuerySelect(GroupedSelect select, String table, WhereClause whereClause)'''
	 «select.select.generateQuerySelect(table, whereClause)» «select.groupBy.generateGroupBy»;'''
	 
	 dispatch def String generateQuerySelect(SortedSelect select, String table, WhereClause whereClause)'''
	 «select.select.generateQuerySelect(table, whereClause)» «select.orderBy.generateOrderBy»;'''
	 
	 dispatch def String generateQuerySelect(GroupSortedSelect select, String table, WhereClause whereClause)'''
	 «select.select.generateQuerySelect(table, whereClause)» «select.groupBy.generateGroupBy» «select.orderBy.generateOrderBy»;'''
	 
	 dispatch def String generateQuerySelect(AggregatedSelect select, String table, WhereClause whereClause)'''
	 SELECT «select.aggregation.generateAggregation»( «select.select.column.generateSQLColumnNameReference» ) FROM «table» «whereClause.generateWhereClause»'''
	 
	 dispatch def String generateSQLTableCommand(Join join)'''
	 SELECT «join.selection.generateJoinSelect» FROM «join.table1.^var.name» «join.joinType.generateJoin» «join.table2.^var.name» ON «join.joinCondition.map[generateJoinCondition].join('')» 
	 '''
	 
	 dispatch def String generateJoinSelect(Select select)''''''
	 
	 dispatch def String generateJoinSelect(CollectionSelect select)'''
	 «select.column.generateSQLColumnNameReference»
	 «if (!select.columns.empty) {',' + select.columns.map[generateSQLColumnNameReference].join(',')}»
	 '''
	 
	 def String generateJoin(JoinType join)'''
	 «if (join == JoinType.INNER_JOIN) {
	 	'INNER JOIN'
	 } else if (join == JoinType.LEFT_JOIN) {
	 	'LEFT JOIN'
	 } else if(join == JoinType.RIGHT_JOIN) {
	 	'RIGHT JOIN'
	 } else {
	 	'FULL JOIN'
	 }»
	 '''
	 
	 def String generateJoinCondition(TableColumnsCondition condition)'''
	 «condition.column1.generateSQLColumnNameReference» = «condition.column2.generateSQLColumnNameReference»
	 '''
}
