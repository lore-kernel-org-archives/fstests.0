Received: from mail-oi0-f42.google.com ([209.85.218.42]:35480 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbcK2JEH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Nov 2016 04:04:07 -0500
Received: by mail-oi0-f42.google.com with SMTP id b126so182360613oia.2
        for <fstests@vger.kernel.org>; Tue, 29 Nov 2016 01:04:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgEgNJtFfauUTXAr9YedbJeNFrZaWAUbEJUzycf=r3Emw@mail.gmail.com>
References: <1480018332-16567-1-git-send-email-amir73il@gmail.com> <CAOQ4uxgEgNJtFfauUTXAr9YedbJeNFrZaWAUbEJUzycf=r3Emw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 29 Nov 2016 10:04:06 +0100
Message-ID: <CAJfpegvCQKDNZ7DQfw+3NYucW2oDVJ5FAJ5nVXBduQqJ-H386w@mail.gmail.com>
Subject: Re: [PATCH] overlay: test ro/rw fd data inconsistecies
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 29, 2016 at 9:53 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Thu, Nov 24, 2016 at 10:12 PM, Amir Goldstein <amir73il@gmail.com> wrote:
>> Introduce a new test to demonstrates a known issue with overlayfs:
>> - process A opens file F for read
>> - process B writes new data to file F
>> - process A reads old data from file F
>>
>> This issue is about to be fixed with a patch set by Miklos Szeredi.
>
> Eryu and all,
>
> I wanted to ask what is the common practice for introducing tests for
> know issues
> that are *about* to be solved.
>
> What is the preferred timing for merging these sort of tests?
> Is it productive to have these tests merged before a fix is merged to master?
> Before a fix is queued for next?
> Before a fix is available?

IMO adding a test doesn't hurt, it'll just indicate that the current
version is broken.  It doesn't have to have any synchronization with
the actual fix.

> I am asking because there are several known issues for overlayfs
> whose fixes are in several different states of maturity and I would like
> to know how to treat the tests I write for them.
>
> FYI, the fix for the test in this patch (test ro/rw fd data inconsistencies)
> is not queued for next yet, but I am hoping it will be.
> Miklos?

I think it's in good shape for 4.10.  I'll try to ping Al about the VFS bits.

Thanks,
Miklos
