Received: from mail-wm0-f50.google.com ([74.125.82.50]:34953 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbcEaQTk (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 31 May 2016 12:19:40 -0400
Received: by mail-wm0-f50.google.com with SMTP id a136so140923863wme.0
        for <fstests@vger.kernel.org>; Tue, 31 May 2016 09:19:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160531125157.GB17018@infradead.org>
References: <1437913255-7524-4-git-send-email-tytso@mit.edu>
 <1454361909-36538-1-git-send-email-gwendal@chromium.org> <20160202180828.GA13880@infradead.org>
 <CAMHSBOUQ5eUL+Y+voDCwC9U7gmTsUZu2Oympn+c0=DxaU4egjA@mail.gmail.com> <20160531125157.GB17018@infradead.org>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Tue, 31 May 2016 09:19:19 -0700
Message-ID: <CAMHSBOU5+XsM503_3khtVBWa+Ymz9BrezGzpxpJEr3axCMuR1Q@mail.gmail.com>
Subject: Re: xfsprogs: Add BUILD_CFLAGS for cross compilation
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, xfs@oss.sgi.com, vapier@gentoo.org
List-ID: <fstests@vger.kernel.org>

[+Mike]
Sure. Mike suggested improvements (ability to specify the host
compiler), and found I did not properly regenerate ./configure. I will
resubmit a better patch.
Gwendal.

On Tue, May 31, 2016 at 5:51 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, May 27, 2016 at 09:34:50AM -0700, Gwendal Grignou wrote:
>> Looking at xfsprogs-4.5.0, that patch has not been applied. Did it not work?
>> It still applies cleanly on 4.5.
>
> It probably just got missed by Dave between all the patches on the list.
> Can you just resend it with my Reviewed-by tag added?
