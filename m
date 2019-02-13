Received: from mail-yw1-f45.google.com ([209.85.161.45]:44672 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbfBMSW0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Feb 2019 13:22:26 -0500
MIME-Version: 1.0
References: <CA+EzBbDyoPF8=mZyG8HQAoHTm4h4MSCe=5WX_SBqRwPej=4uFg@mail.gmail.com>
 <CAOQ4uxh7OayzbGFk0cxoZf_t9jGxesv9k6zPPOA=+5MDsqWOzA@mail.gmail.com> <CA+EzBbC5c-O0ZBuC+UaL7Ftp2Vh8K8d46_6HTBWetY2Otd=tiA@mail.gmail.com>
In-Reply-To: <CA+EzBbC5c-O0ZBuC+UaL7Ftp2Vh8K8d46_6HTBWetY2Otd=tiA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Feb 2019 20:22:13 +0200
Message-ID: <CAOQ4uxi=riQHbaaBxK64SdWdQ1bbHPrPTyXaoOrinG1zggK5gQ@mail.gmail.com>
Subject: Re: Documenting the crash consistency guarantees of file systems
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jaya@cs.utexas.edu>
Cc: fstests <fstests@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Filipe Manana <fdmanana@gmail.com>, Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 13, 2019 at 7:06 PM Jayashree Mohan <jaya@cs.utexas.edu> wrote:
>
> Hi Amir!
>
> Thanks for putting across your thoughts on this. Your suggestions
> definitely make sense, and we'll compile these information and submit
> a patch for review.
>
> When it comes to strictly ordered metadata consistency, to the best of
> our knowledge only xfs claims to provide it explicitly. In ext4,
> delayed allocation and fsync of a file not persisting all its hard
> links[1] are examples of violation to the strictly ordered metadata
> consistency right?

No, I don't think they are.
At least that is not how understand what Ted wrote.

> And for btrfs, they don't seem to explicit about
> providing such semantics. Look at this thread[2] for example, owing to
> the lack of specification, btrfs does not commit to providing such
> guarantees.

The discussion is not about ordered metadata, is it about what
fsync(file) should do. They are related if we decide that fsync(file)
should persist nlink, but I think all fs maintainers are in agreement
that it doesn't matter and btrfs choice is as valid as ext4/xfs choice.

That said, I don't know if btrfs does strictly ordered metadata or not.
Order metadata means if user does op A then op B, you should not be
able to see consequence of op B after crash without seeing the
consequence of op A.

Can you give a counter example for btrfs? for ext4?

The different fsync() guaranties in different filesystems confuse you
because if you expect fsync() to persist op B, then you expect op A
to persist as well, but it may be the former (fsync) expectation that is
failing and not the latter (ordered).

Thanks,
Amir.

>
> [1] https://www.spinics.net/lists/linux-btrfs/msg77340.html
> [2] https://www.spinics.net/lists/linux-btrfs/msg76957.html
