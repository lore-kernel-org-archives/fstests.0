Received: from imap.thunk.org ([74.207.234.97]:50438 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934960AbdEVPff (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 May 2017 11:35:35 -0400
Date: Mon, 22 May 2017 11:35:33 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/2] Drop _require_fssum
Message-ID: <20170522153533.4xoavbkheotrmyml@thunk.org>
References: <20170522010528.23463-1-tytso@mit.edu>
 <20170522010528.23463-2-tytso@mit.edu>
 <20170522144749.GU7250@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522144749.GU7250@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 22, 2017 at 10:47:49PM +0800, Eryu Guan wrote:
> I think this is still needed. It has FSSUM_PROG definition (otherwise
> all these btrfs tests failed due to unable to find $FSSUM_PROG), and we
> do check for existence of binary files in src, even the file is built
> unconditionally on make. They can be removed accidently or one may
> forget to build a newly added test.

Good point; I had missed that.

					- Ted
