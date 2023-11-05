import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Note from 'App/Models/Note'

export default class NotesController {
  public async index({response}: HttpContextContract) {
    try {
        const responseNotesList = await Note.query();
        return response.status(200).json({code: 200, status: "success", data: responseNotesList});
    } catch (error) {
        return response.status(500).json({code: 200, status: "failed to get all notes", message: error.message});
    }
  }

  public async store({request, response}: HttpContextContract) {
    try {
        const {title, description, label_color} = request.body()
        const responseNewNote = await Note.create({title, description, label_color})
        return response.status(201).json({code: 200, status: "success creating a new note", data: responseNewNote});
    } catch (error) {
        return response.status(500).json({code: 500, status: "failed to create a note", message: error.message});
    }
  }

  public async show({}: HttpContextContract) {}

  public async update({request, response, params:{id}}: HttpContextContract) {
    try {
        const {title, description, label_color} = request.body()
        await Note.query().where({id}).update({title, description, label_color})
        const responseUpdateNote = await Note.find(id)
        return response.status(200).json({code: 200, status: "success updating a note", data: responseUpdateNote?.toJSON()});
    } catch (error) {
        return response.status(500).json({code: 200, status: "failed to update a note", message: error.message});
    }
  }

  public async destroy({response, params:{id}}: HttpContextContract) {
    try {
        const responseDeleteNote = await Note.query().where({id}).delete();
        return response.status(200).json({code: 200, status: "success deleting a note", data: {responseDeleteNote}});
    } catch (error) {
        return response.status(500).json({code: 200, status: "failed to deleting a note", message: error.message});
    }
  }
}
