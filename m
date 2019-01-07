Received: from mail-pg1-f177.google.com ([209.85.215.177]:43498 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfAGIrc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Jan 2019 03:47:32 -0500
Received: by mail-pg1-f177.google.com with SMTP id v28so20441158pgk.10
        for <fstests@vger.kernel.org>; Mon, 07 Jan 2019 00:47:32 -0800 (PST)
Date: Mon, 7 Jan 2019 16:47:23 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to f3a1213c2494
Message-ID: <20190107084723.GE2803@desktop>
References: <5c321737.1c69fb81.b9424.ce58@mx.google.com>
 <20190106181054.GF20474@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106181054.GF20474@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jan 06, 2019 at 10:10:54AM -0800, Darrick J. Wong wrote:
> On Sun, Jan 06, 2019 at 10:56:48PM +0800, Eryu Guan wrote:
> > Hi all,
> > 
> > The master branch of the xfstests repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > have just been updated. This is a bugfix-only update, and notably we reverted
> > the RESULT_BASE fix in kmemleak support (sorry for suggesting a wrong fix), it
> > turns that it's the kmemleak infrastracture that needs to be fixed (I'll look
> > into it next week).
> 
> The kmemleak thing is a mess I created, I'll clean it up.

Thanks a lot! :)

Eryu
