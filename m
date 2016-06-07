Received: from mail-it0-f48.google.com ([209.85.214.48]:38613 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbcFGIby (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 7 Jun 2016 04:31:54 -0400
Received: by mail-it0-f48.google.com with SMTP id i65so65727294ith.1
        for <fstests@vger.kernel.org>; Tue, 07 Jun 2016 01:31:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACj3i733G7oz_tg4NANfz_=X5nYMp31k-FskEPXxHsaSxKtTEw@mail.gmail.com>
References: <1464858659-610-1-git-send-email-jtulak@redhat.com>
 <20160607034555.GK5140@eguan.usersys.redhat.com> <CACj3i733G7oz_tg4NANfz_=X5nYMp31k-FskEPXxHsaSxKtTEw@mail.gmail.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Tue, 7 Jun 2016 10:31:34 +0200
Message-ID: <CACj3i72Q=mqQv3kqbPA_YvcFv-hGjaAd7X1h46KPKZ8fYt1UYg@mail.gmail.com>
Subject: Fwd: [PATCH] xfstests: update xfs/096 for new behaviour
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Sorry for the spam, I'm sending it once more and this time it should
pass vger.kernel.org spam filter.

---------- Forwarded message ----------
From: Jan Tulak <jtulak@redhat.com>
Date: Tue, Jun 7, 2016 at 10:18 AM
Subject: Re: [PATCH] xfstests: update xfs/096 for new behaviour
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org


On Tue, Jun 7, 2016 at 5:45 AM, Eryu Guan <eguan@redhat.com> wrote:
>
> On Thu, Jun 02, 2016 at 11:10:59AM +0200, Jan Tulak wrote:
> > Because we recently changed how mkfs behaves when it gets incorrect/invalid
> > values, update the expected output to reflect the change.
>
> This will break test with old-behavior xfsprogs. But I'm not sure what
> the best solution is..


Hmm, well, an "if version > something" could work, together with
testing the changed text directly in the test and making the correct
output quiet.

I can add something like that to xfstests and make it a function
(has_mkfs_old_input_format) for easier use in the tests, but... It
seems that only this single test is broken by the change, and I don't
know if we want this backward compatibility in future tests.

The only case when I see a usage would be finding a bug and then using
the test to bisect the commit, while going over the change boundary.
And will the persons doing this remember that there is a check for
this? Or will they vaguely remember that there was some change and
just look for the version and make their own "if version"?

I would like a centralised solution, but I'm really afraid that it
would be of no use. And moving the output text into the test is the
only way I can think of for this specific test.


>
>
> And it seems that generic/054 and generic/055 are failing because of the
> same reason, if so, fix them together?


These two tests should be fixed by the -l su minval patch, so it is
just this one.

Cheers,
Jan


-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
