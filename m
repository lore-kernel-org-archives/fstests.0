Received: from imap.thunk.org ([74.207.234.97]:58952 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934724AbeFLBlq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 11 Jun 2018 21:41:46 -0400
Date: Mon, 11 Jun 2018 21:41:40 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] get-versions: fix typo in fsverity.ver
Message-ID: <20180612014140.GA4436@thunk.org>
References: <1528719237-1278-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528719237-1278-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 11, 2018 at 03:13:57PM +0300, Amir Goldstein wrote:
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Applied, thanks.

> BTW, why are fsverity and ima-evm-utils required and not
> optional repos?

My general rule of thumb has been to include everything needed for
xfstests on kvm-xfstests and gce-xfstest, but not things needed for
android-xfstests.

The fsverity and ima-evm-utils git repos don't technically meet that
definition yet, but there are patches for tests for fsverity that
would require fsverity.  I've been investigating ways of allow IMA to
use fsverity, so that's why I had included it, but it's certainly much
more of a pre-emptive inclusion compared to fsverity.

Part of it is that adding optional repos means I have to test the
build and test appliance generation with and without the repo, so it's
a tiny bit more work/complexity, and I decided to be lazy / keep
things simple.

If the inclusion of ima-evm-utils is annoying, we could look at making
it be optional.

Cheers,

						- Ted
