Received: from mx1.redhat.com ([209.132.183.28]:56424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755053AbdIGOGz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Sep 2017 10:06:55 -0400
Date: Thu, 7 Sep 2017 22:06:52 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4 5/5] fsx: add support for keeping existing file
Message-ID: <20170907140652.GT8034@eguan.usersys.redhat.com>
References: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
 <1504769198-4921-6-git-send-email-amir73il@gmail.com>
 <CAOQ4uxhFEVc4CCj1eCecVrGYrz4WqH_a0rEdBkTjtnTLd-dUBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhFEVc4CCj1eCecVrGYrz4WqH_a0rEdBkTjtnTLd-dUBw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 07, 2017 at 03:38:59PM +0300, Amir Goldstein wrote:
> On Thu, Sep 7, 2017 at 10:26 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> > With fsx -k, do not truncate existing file and use its size as upper
> > bound on file size.
> >
> > This is needed to prevent fsx from truncating the file on start of
> > test when testing fsx on cloned files.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> 
> > -       if (lite) {
> > +       if (!(o_flags & O_TRUNC)) {
> >                 off_t ret;
> > -               file_size = maxfilelen = lseek(fd, (off_t)0, SEEK_END);
> > +               file_size = maxfilelen = biggest = lseek(fd, (off_t)0, SEEK_END);
> > +               prt("file_size is %lu\n", file_size);
> 
> Eryu,
> 
> Please remove this added debug log before merging.
> It breaks expected output of test generic/127

Sure, thanks for the heads-up.

Eryu
