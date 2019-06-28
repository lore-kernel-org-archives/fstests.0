Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51779 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726616AbfF1Ofl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jun 2019 10:35:41 -0400
Date: Fri, 28 Jun 2019 10:35:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/5] shared,ext4: move ext4-specific tests out of shared/
Message-ID: <20190628143536.GD6181@mit.edu>
References: <20190623230956.24670-1-tytso@mit.edu>
 <20190628094030.GD7943@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628094030.GD7943@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 28, 2019 at 05:40:30PM +0800, Eryu Guan wrote:
> > 
> > 	shared/001 --> ext4/036
> > 	shared/003 --> ext4/037
> > 	shared/004 --> ext4/038
> > 	shared/272 --> ext4/039
> 
> Looks like shared/001 and shared/004 are not journal related and could
> run with ext2 as well. So the two tests should be part of patch 3?

Orphaned inodes is something which is only a thing with ext3/ext4.
The fact that these tests pass on ext2 is purely a happy accident ---
because ext2 completely ignores the orphaned list.  I suppose I should
just remove ext2 from the supported list, but these tests take a super
small amount of time so why the tests are kinda pointless for ext2, it
doesn't cost much time, either.

> And I guess we should update "_supported_fs" field in ext4/037 and
> ext4/039 too, so they only support ext4.

ext4/037 should have be marked as only supported by ext3 and ext4.
It's passing by accident on my system because I have
CONFIG_EXT4_USE_FOR_EXT2, and so the lack of the noload mount option
wasn't tripping up the test and causing a test failure.  (The fact
that no one has complained is actually a really strong suggestion that
most people running xfstests have EXT4_USE_FOR_EXT2 enabled.)  I'll fix this.

ext4/039 is right as is; it makes sense for ext3 and ext4, and if
someone is testing with FSTYP=ext3 we do want to run that test.

I'll adjust some of the supported_fs lines in the next version.

						- Ted
