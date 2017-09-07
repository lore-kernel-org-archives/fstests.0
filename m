Received: from mail-yw0-f175.google.com ([209.85.161.175]:33365 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755282AbdIGMjA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 08:39:00 -0400
Received: by mail-yw0-f175.google.com with SMTP id s62so14576712ywg.0
        for <fstests@vger.kernel.org>; Thu, 07 Sep 2017 05:39:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504769198-4921-6-git-send-email-amir73il@gmail.com>
References: <1504769198-4921-1-git-send-email-amir73il@gmail.com> <1504769198-4921-6-git-send-email-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Sep 2017 15:38:59 +0300
Message-ID: <CAOQ4uxhFEVc4CCj1eCecVrGYrz4WqH_a0rEdBkTjtnTLd-dUBw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] fsx: add support for keeping existing file
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 7, 2017 at 10:26 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> With fsx -k, do not truncate existing file and use its size as upper
> bound on file size.
>
> This is needed to prevent fsx from truncating the file on start of
> test when testing fsx on cloned files.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

> -       if (lite) {
> +       if (!(o_flags & O_TRUNC)) {
>                 off_t ret;
> -               file_size = maxfilelen = lseek(fd, (off_t)0, SEEK_END);
> +               file_size = maxfilelen = biggest = lseek(fd, (off_t)0, SEEK_END);
> +               prt("file_size is %lu\n", file_size);

Eryu,

Please remove this added debug log before merging.
It breaks expected output of test generic/127

Amir.
