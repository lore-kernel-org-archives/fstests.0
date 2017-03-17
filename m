Received: from mail-ot0-f195.google.com ([74.125.82.195]:36089 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdCQMoV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Mar 2017 08:44:21 -0400
Received: by mail-ot0-f195.google.com with SMTP id i1so12401664ota.3
        for <fstests@vger.kernel.org>; Fri, 17 Mar 2017 05:44:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489752862-15786-1-git-send-email-zlang@redhat.com>
References: <1489752862-15786-1-git-send-email-zlang@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Mar 2017 14:44:13 +0200
Message-ID: <CAOQ4uxh77DoqDa+O0NvjABzhosZWWG5_COy6=4U5s5eDwpPPUw@mail.gmail.com>
Subject: Re: [PATCH] fsstress: add mmap/munmap into test operation list
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 17, 2017 at 2:14 PM, Zorro Lang <zlang@redhat.com> wrote:
> mmap as a popular and basic operation, most of softwares use it to
> access files.
>
> More and more customers report bugs related with mmap/munmap and
> other stress conditions. So add mmap test into fsstress to reproduce
> or find more bugs easily.
>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>
> Hi,
>
> I've tested this patch on XFS by running:
>
> ./ltp/fsstress -d /mnt/scratch -f mmap=1000 -f creat=500 -f mkdir=500 -n 2000 -p10 -v
> ./ltp/fsstress -d /mnt/scratch -f mmap=1000 -f dwrite=1000 -f write=1000 -f creat=500 -f mkdir=500 -n 4000 -p10 -v
> ./ltp/fsstress -d /mnt/scratch -n 5000 -p10 -v
>
> I didn't find any unexpected errors. Please help to review.
> I'll send another patch to LTP if this patch can be merged into xfstests.
>
> Thanks,
> Zorro
>
>  ltp/fsstress.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/global.h   |  4 +++
>  2 files changed, 81 insertions(+)
>
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 35e2765..5914551 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -2585,7 +2585,84 @@ link_f(int opno, long r)
>  void
>  mmap_f(int opno, long r)
>  {

IMO, the operation you implemented would be better named 'mwrite'
and it makes sense while you're at it to add 'mread' counterpart.

It might have been nice to have 'mmap'/'munmap' commands
which actually maintain a set of files on which mwrite/mread acts
upon, similarly to the relation between creat/unlink and the rest of
the file ops.

This could actually allow to stress test concurrent access the shared memory
between processes, but it is going to be a lot more work...
So for now mwrite/mread imply mmap+mwrite/mread+munmap

Amir.
