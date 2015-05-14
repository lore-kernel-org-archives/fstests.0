Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33465 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbbENH4v (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 May 2015 03:56:51 -0400
Received: by oica37 with SMTP id a37so50195789oic.0
        for <fstests@vger.kernel.org>; Thu, 14 May 2015 00:56:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150514031952.GP15721@dastard>
References: <20150512234005.GC4316@dastard>
	<1431475654-23274-1-git-send-email-andreas.gruenbacher@gmail.com>
	<20150514031952.GP15721@dastard>
Date: Thu, 14 May 2015 09:56:50 +0200
Message-ID: <CAHpGcMKfobLMLXDzX2qQhpqvGotbwHh-n3o9+NeVEtwahUMXdQ@mail.gmail.com>
Subject: Re: [PATCH] generic/326: Test the permission to set file times
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

2015-05-14 5:19 GMT+02:00 Dave Chinner <david@fromorbit.com>:
> Fails on XFS.
>
> /me looks at fs_perms and shudders at all the system() calls.
>
> Looks like there is no testx.file created first.

Hmm, that file was lying around from a previous run here.
Leaky tests are fun.

> should this actually be doing "rm -f"?

That's better, indeed.

Thanks for fixing up my xfstests beginner's mistakes.

Andreas
