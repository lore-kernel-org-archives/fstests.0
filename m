Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7D2C001DF
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jul 2023 19:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGXTw2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGXTw2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2023 15:52:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649FFDB
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2023 12:52:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8D6F68AFE; Mon, 24 Jul 2023 21:52:23 +0200 (CEST)
Date:   Mon, 24 Jul 2023 21:52:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230724195223.GA30368@lst.de>
References: <20230724152927.33094-1-hch@lst.de> <20230724152927.33094-2-hch@lst.de> <20230724182326.tbrk7nwqukfmsl3k@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724182326.tbrk7nwqukfmsl3k@aalbersh.remote.csb>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 24, 2023 at 08:23:26PM +0200, Andrey Albershteyn wrote:
> > +# open a file descriptor for reading the file
> > +exec 3< $SCSI_DEBUG_MNT/testfile
> > +
> > +# delete the scsi debug device while it still has dirty data
> > +echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> > +
> > +# try to read from the file, which should give us -EIO
> > +cat <&3 > /dev/null
> 
> hmm, maybe I missing something but won't cat always return -EIO
> here? I suppose the test will also pass without the behaviour you
> introduced.

What do you mean with always?  If the file system isn't shut down
the read could succeed, and it could return a different error.
Right now btrfs for example will not return -EIO here.

