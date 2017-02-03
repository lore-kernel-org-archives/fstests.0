Received: from mail-oi0-f48.google.com ([209.85.218.48]:34576 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbdBCKcW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2017 05:32:22 -0500
Received: by mail-oi0-f48.google.com with SMTP id s203so8682644oie.1
        for <fstests@vger.kernel.org>; Fri, 03 Feb 2017 02:32:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170203095606.GA28569@lst.de>
References: <20170202162755.21101-1-hch@lst.de> <CAOQ4uxiPdAvGe7LT9OtvGJrXozxtTxQi_iDU--y_9aPUTsSkaA@mail.gmail.com>
 <20170203095606.GA28569@lst.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 3 Feb 2017 12:32:21 +0200
Message-ID: <CAOQ4uxh4Wp8YtX283=X0Kp=8BXZCdeoPamBAwimpq2RmZkxkKg@mail.gmail.com>
Subject: Re: [PATCH] generic/407: check that destination timestamps are
 updated on clone
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 3, 2017 at 11:56 AM, Christoph Hellwig <hch@lst.de> wrote:
>> Although this may be nit picking, why 2 seconds?
>
> Copied from a test that did it, 1 is enough though.

Yes, I saw that, generic/215 which was copied from generic/080 I guess
someone should clean up those 2 some time.

And while we are busy saving more angels lives, do 407 and 408 really need
to be separate tests?
How about consolidating them into a single test that works with 2 sets of files?
Sorry again for nit picking on those lost seconds.
