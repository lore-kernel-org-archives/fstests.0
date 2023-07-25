Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C7DC001DF
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Jul 2023 09:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGYJpq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Jul 2023 05:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGYJpp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jul 2023 05:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D311B
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690278302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cutxQXQWasnsx41xvfIPKEhvoFgpEzbzL2owey/yrH0=;
        b=WulAxmzlwiISmGPqqf/RrdWf1cPb2IzirE0vbe58eiLYhgwf8PIOwB+dqjHXOFW+6wHfNz
        yuWS3Gigjd11Xb9Y1Qa5X12ip8ZdRtjXvXl1ZMROydXJkUFTQs+WQ0wnnYO1dqEm9WLoVb
        48pvh+zvMV7ImyxLiTe0pUbwe+Z2TcQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-u2JZcIasMMmgYobC-Q4mjQ-1; Tue, 25 Jul 2023 05:45:00 -0400
X-MC-Unique: u2JZcIasMMmgYobC-Q4mjQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fc08d6a40cso26304935e9.0
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 02:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690278299; x=1690883099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cutxQXQWasnsx41xvfIPKEhvoFgpEzbzL2owey/yrH0=;
        b=NRRxGyAMyuQRTh22gGOCw90uIEkNlT95lMhjtsQWTW46G6ld6O3FbJA5kAl7ujB/3+
         f9vdIclm+kiexIuNkRc3/4xhuYOF0BEwMqwPf+fPbFmvidH9oxAMQdHouEw/cg4yaEU7
         wjm/4icNLc9aXmliUnIn1JzrYuax2bpfCV/IxhRZK79mYBuORJt0KUDrhfBY0VJ23o7b
         3bRSRMEqxLYw/piZxSHSsqzE/Cwq6F4ATCyVOrzRdxD4Odh8iJNivXnBiTNfMIev71vH
         JIfWtjq38QYswaoLuYxCGop4AykY+HBy9/BElOkLHRaXKQkriC3RXE6rgrwkPWc57QON
         sjkw==
X-Gm-Message-State: ABy/qLauhVuVbH9TOMysG+4TCl+jDDNEUkJObQ3Dqge+3g34Y2SYbGbF
        uXbuHuowtLrooPOG+iSO/Jgv9o5Fdew7DwrLCW8OZofErurk3IpKYPEEpS5XAmXbBiJ9cVFEAjO
        Ie5AmMHGDN06qghdJjpWcDzWq
X-Received: by 2002:a05:6000:181c:b0:314:1d7f:a69 with SMTP id m28-20020a056000181c00b003141d7f0a69mr8527138wrh.67.1690278299146;
        Tue, 25 Jul 2023 02:44:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+4W6dPwiT23AEaA4bjk2X9VTSRvAGWBPXf0gmMnI0qgC8MJMa7JltPBlrSTZtw8AGbtulow==
X-Received: by 2002:a05:6000:181c:b0:314:1d7f:a69 with SMTP id m28-20020a056000181c00b003141d7f0a69mr8527119wrh.67.1690278298557;
        Tue, 25 Jul 2023 02:44:58 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003fc3b03caa5sm1069998wms.1.2023.07.25.02.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:44:58 -0700 (PDT)
Date:   Tue, 25 Jul 2023 11:44:56 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230725094456.njzytksrquguzzl4@aalbersh.remote.csb>
References: <20230724152927.33094-1-hch@lst.de>
 <20230724152927.33094-2-hch@lst.de>
 <20230724182326.tbrk7nwqukfmsl3k@aalbersh.remote.csb>
 <20230724195223.GA30368@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724195223.GA30368@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023-07-24 21:52:23, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 08:23:26PM +0200, Andrey Albershteyn wrote:
> > > +# open a file descriptor for reading the file
> > > +exec 3< $SCSI_DEBUG_MNT/testfile
> > > +
> > > +# delete the scsi debug device while it still has dirty data
> > > +echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> > > +
> > > +# try to read from the file, which should give us -EIO
> > > +cat <&3 > /dev/null
> > 
> > hmm, maybe I missing something but won't cat always return -EIO
> > here? I suppose the test will also pass without the behaviour you
> > introduced.
> 
> What do you mean with always? 

oh sorry, not always, I was thinking about xfs and it seems to go
into shutdown in log i/o processing.

> If the file system isn't shut down
> the read could succeed, and it could return a different error.
> Right now btrfs for example will not return -EIO here.
> 

I see, thanks.

-- 
- Andrey

