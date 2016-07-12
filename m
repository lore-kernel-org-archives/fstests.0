Received: from mail-it0-f48.google.com ([209.85.214.48]:37548 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcGLH3w (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 12 Jul 2016 03:29:52 -0400
Received: by mail-it0-f48.google.com with SMTP id f6so8368032ith.0
        for <fstests@vger.kernel.org>; Tue, 12 Jul 2016 00:29:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160712023253.GQ12670@dastard>
References: <1467389347-2055-1-git-send-email-jtulak@redhat.com>
 <1467389347-2055-2-git-send-email-jtulak@redhat.com> <20160704014040.GA27480@dastard>
 <CACj3i71NDjsyTKc8vt9X-VZzRjZpbM=HYp5mx2MFVLrTB-GGYw@mail.gmail.com> <20160712023253.GQ12670@dastard>
From: Jan Tulak <jtulak@redhat.com>
Date: Tue, 12 Jul 2016 09:29:32 +0200
Message-ID: <CACj3i72Rs2MzJEsHPHVTu3jNavAKys7tP2KnhFjEUmGCSY_Q6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] xfstests: Fix installation for extended names
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 12, 2016 at 4:32 AM, Dave Chinner <david@fromorbit.com> wrote:
>> Thanks for your code. I submitted a modified patch, though I have a question...
>> Should I put you into Signed-of-by in this case, as you wrote most of
>> the new version of this patch?
>
> No. You wrote the patch, so it needs your SOB. The usual thing to do
> here is add a line to the commit message saying something like:
>
>         "Based on work/idea/prototype/code from ..."
>
> that way it's clear where it originally came from. If the maintainer
> requires further verification of the source of the code, I can ack
> the patch you sent to the list.
>

OK, thanks. Exactly as I did it. :-)

Thanks,
Jan


-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
