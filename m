Received: from newman.cs.utexas.edu ([128.83.139.110]:34279 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfBMRLs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Feb 2019 12:11:48 -0500
MIME-Version: 1.0
References: <CA+EzBbDyoPF8=mZyG8HQAoHTm4h4MSCe=5WX_SBqRwPej=4uFg@mail.gmail.com>
 <CAOQ4uxh7OayzbGFk0cxoZf_t9jGxesv9k6zPPOA=+5MDsqWOzA@mail.gmail.com>
In-Reply-To: <CAOQ4uxh7OayzbGFk0cxoZf_t9jGxesv9k6zPPOA=+5MDsqWOzA@mail.gmail.com>
From: Jayashree Mohan <jaya@cs.utexas.edu>
Date: Wed, 13 Feb 2019 11:06:23 -0600
Message-ID: <CA+EzBbC5c-O0ZBuC+UaL7Ftp2Vh8K8d46_6HTBWetY2Otd=tiA@mail.gmail.com>
Subject: Re: Documenting the crash consistency guarantees of file systems
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Filipe Manana <fdmanana@gmail.com>, Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Amir!

Thanks for putting across your thoughts on this. Your suggestions
definitely make sense, and we'll compile these information and submit
a patch for review.

When it comes to strictly ordered metadata consistency, to the best of
our knowledge only xfs claims to provide it explicitly. In ext4,
delayed allocation and fsync of a file not persisting all its hard
links[1] are examples of violation to the strictly ordered metadata
consistency right? And for btrfs, they don't seem to explicit about
providing such semantics. Look at this thread[2] for example, owing to
the lack of specification, btrfs does not commit to providing such
guarantees.

Thanks,
Jayashree

[1] https://www.spinics.net/lists/linux-btrfs/msg77340.html
[2] https://www.spinics.net/lists/linux-btrfs/msg76957.html
