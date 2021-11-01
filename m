Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97797C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 15:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A355600CC
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 15:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhKAPwf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Nov 2021 11:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhKAPwe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Nov 2021 11:52:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB80C061714
        for <fstests@vger.kernel.org>; Mon,  1 Nov 2021 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K8jRukm2NqdstrZ/nPyjYuPTs9ID81822GKxQRCdpXk=; b=fTIkdMep6Fx9BhUOwld/6E2wXB
        G10RkW5WMnxvOhF8IO5Vk7PBT8EAherXda7PNgKx2HVgx7p+WVbZ+I7VYOplaTdNhAoOEimKiNQRy
        uxYx0291Iaqp/Cwo+zu1yI9eTpLT4LrlaupbLoVrI9NxA7QIqUl07hxO7qQ/zzvvUC4WBY2AMOak3
        5RjnHhUnsJWVX48MuqjS7ZXyowK9pWcioQQwJSk7iDEiCwYY5mYs+zX5+GhX+NrmbqwKc0dRacD2I
        AsRfpx4zdTOsicF0wReq4HH9FCKxZ5H2TZU9AQA1jXdT3mneMEvdfS2Wh/wX9SOr8rwf00m5KwZf/
        MwlA9pOg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhZZR-00GjEh-CX; Mon, 01 Nov 2021 15:50:01 +0000
Date:   Mon, 1 Nov 2021 08:50:01 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: Re: [PATCH] fsstress: improve error message on check_cwd() error
Message-ID: <YYAMqeWUJfbKM4N1@bombadil.infradead.org>
References: <20210921175035.1286786-1-mcgrof@kernel.org>
 <CAL3q7H4hvwDcio3qqTbQj0BK9GbEeGhfbx2F32WBpB3D5nKL8Q@mail.gmail.com>
 <YUuM/h7zGaAsPggl@bombadil.infradead.org>
 <CAL3q7H6yykw_roQvF-vS3DHyMh9hLmagq1ZamQqqWJWLwafsYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6yykw_roQvF-vS3DHyMh9hLmagq1ZamQqqWJWLwafsYA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 23, 2021 at 01:37:04PM +0100, Filipe Manana wrote:
> On Wed, Sep 22, 2021 at 9:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Sep 22, 2021 at 11:15:08AM +0100, Filipe Manana wrote:
> > > > +       fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%ld) != top_ino (%ld)\n",
> > > > +               (long)statbuf.st_ino, (long)top_ino);
> > >
> > > ino_t is guaranteed to be an unsigned integer, and can be either 64 or
> > > 32 bits wide [1].
> > > Casting to unsigned 64 bits would be better imo.
> >
> > There are other similar mi-uses in the code, should I fix those to
> > then?
> 
> If you want to, as a separate patch.

> Since the code is using struct stat64, using %llu
> for the printfs without any casts should be fine [1].

You mean %lu because with %llu there is a warning.

  Luis
