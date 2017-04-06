Received: from mail-it0-f50.google.com ([209.85.214.50]:35637 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbdDFSTt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Apr 2017 14:19:49 -0400
Received: by mail-it0-f50.google.com with SMTP id y18so106323431itc.0
        for <fstests@vger.kernel.org>; Thu, 06 Apr 2017 11:19:49 -0700 (PDT)
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
 <20170406135524.GA12230@infradead.org>
 <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
 <20170406144741.GA27776@infradead.org>
 <bb45e36c-93af-9565-1dc0-a4850aec393c@kernel.dk>
 <20170406152000.GF3768@linux-x5ow.site>
 <b7b785ef-21a6-19f6-07c6-5dcc3053f274@sandeen.net>
 <20170406181555.GA8215@linux-x5ow.site>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b58871ff-2b34-acce-318c-479dccf4d596@kernel.dk>
Date: Thu, 6 Apr 2017 12:19:46 -0600
MIME-Version: 1.0
In-Reply-To: <20170406181555.GA8215@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>, Eric Sandeen <sandeen@sandeen.net>
Cc: Christoph Hellwig <hch@infradead.org>, Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 04/06/2017 12:15 PM, Johannes Thumshirn wrote:
> On Thu, Apr 06, 2017 at 10:32:43AM -0500, Eric Sandeen wrote:
>> Full-blown xfstests doesn't have /that/ much in the way of deps,
>> on debian it's ostensibly just:
>>
>>                 sudo apt-get install xfslibs-dev uuid-dev libtool-bin \
>>                 e2fsprogs automake gcc libuuid1 quota attr libattr1-dev make \
>>                 libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench \
>>                 uuid-runtime
>>
>> and lots of that might not be needed for non-fs tests.
>>
>> Otherwise well, you do need bash ... ;)
> 
> Yeah that's OK. Maybe I misphrased it a bit. No more additional dependencies.
> Currently xfstest is "small" engough to be run in an initrd and that's good
> for qemu -kernel .. -initrd .. style test runs.

We share that goal. The block related tests will have _fewer_ dependencies.
And it'll also be Linux only, so we don't have to worry about cross platform.

-- 
Jens Axboe

