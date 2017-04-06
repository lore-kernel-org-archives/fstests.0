Received: from mail-io0-f169.google.com ([209.85.223.169]:33613 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935207AbdDFOeD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Apr 2017 10:34:03 -0400
Received: by mail-io0-f169.google.com with SMTP id f84so30699571ioj.0
        for <fstests@vger.kernel.org>; Thu, 06 Apr 2017 07:34:03 -0700 (PDT)
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
 <20170406135524.GA12230@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
Date: Thu, 6 Apr 2017 08:33:55 -0600
MIME-Version: 1.0
In-Reply-To: <20170406135524.GA12230@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 04/06/2017 07:55 AM, Christoph Hellwig wrote:
> I still disagree with using xfstests for this.  Even if we were going
> to treat the block devices nodes as yet another file system that's not
> what the patches do - they create specific virtual devices to test
> for each test.
> 
> I think the right way is to keep your patches as-is and copy the few
> bits you use from xfstests into a new repository.

That is exactly what my recommendation was at lsfmm as well - fork
xfstest, prune bits we don't need, and off we go. I'll get around to
it soonish.

-- 
Jens Axboe

