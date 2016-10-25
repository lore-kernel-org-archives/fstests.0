Received: from imap.thunk.org ([74.207.234.97]:41838 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932312AbcJYQvT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Oct 2016 12:51:19 -0400
Date: Tue, 25 Oct 2016 12:51:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: add kernel configs for 4.9
Message-ID: <20161025165116.7zzhjnfhsnwrc2r5@thunk.org>
References: <1477081648-86880-1-git-send-email-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1477081648-86880-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I ended up checking in a slightly different set of kernel configs.
The main differences were (a) enable more kernel debugging config
options, which improve testing, and (b) removed some unneeded hardware
support which aren't needed for running the 32-bit kernel under KVM.

Cheers,

					- Ted
