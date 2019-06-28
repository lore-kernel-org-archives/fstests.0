Received: from mail-yb1-f194.google.com ([209.85.219.194]:38931 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfF1IEJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jun 2019 04:04:09 -0400
Received: by mail-yb1-f194.google.com with SMTP id k4so3244731ybo.6
        for <fstests@vger.kernel.org>; Fri, 28 Jun 2019 01:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190513014904.4275-1-zlang@redhat.com>
In-Reply-To: <20190513014904.4275-1-zlang@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 28 Jun 2019 11:03:57 +0300
Message-ID: <CAOQ4uxh2DLXWSQiyJfJpmzTYwQL4HVGSBwTsxMn_eqLU0rx+7A@mail.gmail.com>
Subject: Re: [PATCH] xfstests: aio random write and verify stress test
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>, "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, May 13, 2019 at 4:57 AM Zorro Lang <zlang@redhat.com> wrote:
>
> We found some AIO write related bugs recently, so I think a AIO
> random write test is needed. By the new aio-aio-write-verify.c tool,
> we can do this easily.
>

Is it just me or does this test gets killed by OOM killer for anyone else?
(generic/551).

It always gets killed on a 2GB RAM VM and once got killed on 8GB RAM VM.

At least I can verify that Darrick's fix is working as expected
("check: try to insulate the test framework from oom killer")

Thanks,
Amir.
