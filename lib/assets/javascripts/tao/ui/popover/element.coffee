#= require ./direction
#= require ./position

{Direction, Position} = Tao.Popover

class Tao.Popover.Element extends TaoComponent

  @tag 'tao-popover'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'targetSelector', 'targetTraversal', 'triggerSelector', 'triggerTraversal'

  @attribute 'triggerAction', default: 'click'

  @attribute 'boundarySelector', 'direction', 'arrowAlign', 'arrowVerticalAlign'

  @attribute 'offset', type: 'number', default: 0

  @attribute 'autoHide', type: 'boolean'

  _connected: ->
    @_initTarget()
    @_initTrigger()
    @_activeChanged() if @active

  _initTarget: ->
    @target = if @targetTraversal && @targetSelector
      @jq[@targetTraversal]?(@targetSelector)
    else if @targetSelector
      $ @targetSelector

  _initTrigger: ->
    @triggerEl = if @triggerTraversal && @triggerSelector
      @jq[@triggerTraversal]?(@triggerSelector)
    else if @triggerSelector
      $ @triggerSelector
    else
      @target

    if @triggerAction == 'click'
      @triggerEl.on 'click.tao-popover', (e) =>
        @toggleActive()
    else if @triggerAction == 'hover'
      @triggerEl.on 'mouseenter.tao-popover', (e) =>
        @active = true
      .on 'mouseleave.tao-popover', (e) =>
        @active = false

  _activeChanged: ->
    if @active
      @refresh()
      @_enableAutoHide() if @autoHide
    else
      @_disableAutoHide() if @autoHide

  _enableAutoHide: ->
    $(document).on "mousedown.tao-popover-#{@taoId}", (e) =>
      return unless @active
      target = $ e.target
      return if target.is(@target) or @jq.has(target).length or target.is(@)
      @active = false

  _disableAutoHide: ->
    $(document).off "mousedown.tao-popover-#{@taoId}"

  refresh: ->
    unless @direction
      direction = new Direction
        popover: @jq
        target: @target
        boundarySelector: @boundarySelector
      @direction = direction.toString()

    @position = new Position
      popover: @jq
      target: @target
      direction: @direction.split('-')
      arrowAlign: @arrowAlign
      arrowVerticalAlign: @arrowVerticalAlign
      offset: @offset

    @jq.css
      top: @position.top
      left: @position.left

  toggleActive: ->
    @active = !@active

  _disconnected: ->
    @triggerEl.off '.tao-popover'
    $(document).off ".tao-popover-#{@taoId}"

TaoComponent.register Tao.Popover.Element