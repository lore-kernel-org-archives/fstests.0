Received: from mail-io0-f171.google.com ([209.85.223.171]:33182 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755841AbdDFOvi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Apr 2017 10:51:38 -0400
Received: by mail-io0-f171.google.com with SMTP id f84so31077782ioj.0
        for <fstests@vger.kernel.org>; Thu, 06 Apr 2017 07:51:38 -0700 (PDT)
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
 <20170406135524.GA12230@infradead.org>
 <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
 <20170406144741.GA27776@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bb45e36c-93af-9565-1dc0-a4850aec393c@kernel.dk>
Date: Thu, 6 Apr 2017 08:51:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170406144741.GA27776@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 04/06/2017 08:47 AM, Christoph Hellwig wrote:
> On Thu, Apr 06, 2017 at 08:33:55AM -0600, Jens Axboe wrote:
>> That is exactly what my recommendation was at lsfmm as well - fork
>> xfstest, prune bits we don't need, and off we go. I'll get around to
>> it soonish.
> 
> So you volunteer to do it?  I was -><- this close to offering it myself,
> and than thought of all the other backlog I have on my plate :)

Yeah, I'll get something cobbled together next week.

-- 
Jens Axboe

