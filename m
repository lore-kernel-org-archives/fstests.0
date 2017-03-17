Received: from mail-ot0-f196.google.com ([74.125.82.196]:35372 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdCQOOc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Mar 2017 10:14:32 -0400
Received: by mail-ot0-f196.google.com with SMTP id a12so12797316ota.2
        for <fstests@vger.kernel.org>; Fri, 17 Mar 2017 07:13:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317132710.GJ21915@dhcp12-143.nay.redhat.com>
References: <1489752862-15786-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxh77DoqDa+O0NvjABzhosZWWG5_COy6=4U5s5eDwpPPUw@mail.gmail.com> <20170317132710.GJ21915@dhcp12-143.nay.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Mar 2017 16:03:43 +0200
Message-ID: <CAOQ4uxhv63-ngWrNsX=h7ywet1_qotNcPoAjzQbg4w-MusLQDA@mail.gmail.com>
Subject: Re: [PATCH] fsstress: add mmap/munmap into test operation list
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 17, 2017 at 3:27 PM, Zorro Lang <zlang@redhat.com> wrote:
> On Fri, Mar 17, 2017 at 02:44:13PM +0200, Amir Goldstein wrote:
>> On Fri, Mar 17, 2017 at 2:14 PM, Zorro Lang <zlang@redhat.com> wrote:
>> > mmap as a popular and basic operation, most of softwares use it to
>> > access files.
>> >
>> > More and more customers report bugs related with mmap/munmap and
>> > other stress conditions. So add mmap test into fsstress to reproduce
>> > or find more bugs easily.
>> >
>> > Signed-off-by: Zorro Lang <zlang@redhat.com>
>> > ---
>> >
>> > Hi,
>> >
>> > I've tested this patch on XFS by running:
>> >
>> > ./ltp/fsstress -d /mnt/scratch -f mmap=1000 -f creat=500 -f mkdir=500 -n 2000 -p10 -v
>> > ./ltp/fsstress -d /mnt/scratch -f mmap=1000 -f dwrite=1000 -f write=1000 -f creat=500 -f mkdir=500 -n 4000 -p10 -v
>> > ./ltp/fsstress -d /mnt/scratch -n 5000 -p10 -v
>> >
>> > I didn't find any unexpected errors. Please help to review.
>> > I'll send another patch to LTP if this patch can be merged into xfstests.
>> >
>> > Thanks,
>> > Zorro
>> >
>> >  ltp/fsstress.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >  src/global.h   |  4 +++
>> >  2 files changed, 81 insertions(+)
>> >
>> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
>> > index 35e2765..5914551 100644
>> > --- a/ltp/fsstress.c
>> > +++ b/ltp/fsstress.c
>> > @@ -2585,7 +2585,84 @@ link_f(int opno, long r)
>> >  void
>> >  mmap_f(int opno, long r)
>> >  {
>
> Hi Amir,
>
> Thanks for your reviewing.
>
>>
>> IMO, the operation you implemented would be better named 'mwrite'
>> and it makes sense while you're at it to add 'mread' counterpart.
>
> Hmm, make sense.
>
>>
>> It might have been nice to have 'mmap'/'munmap' commands
>> which actually maintain a set of files on which mwrite/mread acts
>> upon, similarly to the relation between creat/unlink and the rest of
>> the file ops.
>>
>> This could actually allow to stress test concurrent access the shared memory
>> between processes, but it is going to be a lot more work...
>
> If so, I have to record addr and length with file together in mwrite when
> mmap a file, and one file maybe mapped not only once. Then mread
> need to choose one addr+length+file group randomly to test and munmap.
>
> Hmm... That's a good suggestion. But I just hope to add some mmap/munmap
> random load I/Os in fsstress, to trigger more writeback + munmap + memory reclaim
> race situations in this simple patch. I didn't plan to test concurrent access
> the shared memory this time, due to what you said, it's going to be lots more
> work:)
>
> How about add this feature in later patch, after this patch can be merged?
> What do you think?
>

Certainly. I wasn't implying that your patch should be blocked.
My only review comment was to name of the operation which is misleading.
