Received: from mail-pg0-f65.google.com ([74.125.83.65]:33969 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbcLSTZX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Dec 2016 14:25:23 -0500
Received: by mail-pg0-f65.google.com with SMTP id b1so9293132pgc.1
        for <fstests@vger.kernel.org>; Mon, 19 Dec 2016 11:25:22 -0800 (PST)
Date: Mon, 19 Dec 2016 11:25:20 -0800
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [RFC][PATCH 0/2] xfstests on ubifs
Message-ID: <20161219192520.GA37112@gmail.com>
References: <1482173132-100690-1-git-send-email-ebiggers3@gmail.com>
 <16b0ba94-bdef-00c5-acd9-d19200f81ecd@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b0ba94-bdef-00c5-acd9-d19200f81ecd@nod.at>
Sender: fstests-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org, linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 19, 2016 at 08:12:07PM +0100, Richard Weinberger wrote:
> 
> > Note 2: since mkfs.ubifs doesn't support creating encryption-capable filesystems
> > yet (ubifs v5), to get the encryption tests to work I also had to hack
> > _scratch_mkfs_encrypted() to use ubirmvol/ubimkvol instead of mkfs.  I assume
> > that the ubifs developers are planning to update mkfs.ubifs.
> 
> You don't have to run mkfs.ubifs, just mount an empty UBI volume, UBIFS will auto-
> crate a encryption capable fs.

Yeah, that's what I ended up doing.  I didn't include it in the official patch
since it was a complete hack, but here's what I did.  Of course the real
solution would be to update mkfs.ubifs and then just use _scratch_mkfs:

diff --git a/common/encrypt b/common/encrypt
index f09104d..261a1f7 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -71,6 +71,11 @@ _scratch_mkfs_encrypted()
 	ext4|f2fs)
 		_scratch_mkfs -O encrypt
 		;;
+	ubifs)
+		local ubi=${SCRATCH_DEV%_0}
+		ubirmvol $ubi -N vol
+		ubimkvol $ubi -N vol -m
+		;;
 	*)
 		_notrun "No encryption support for $FSTYP"
 		;;
