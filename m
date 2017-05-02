Received: from imap.thunk.org ([74.207.234.97]:38510 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdEBEmW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 May 2017 00:42:22 -0400
Date: Tue, 2 May 2017 00:42:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] test-appliance: limit checkpointing to gce-xfstests only
Message-ID: <20170502044221.h52uiell5zz4rer4@thunk.org>
References: <20170501170432.94512-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170501170432.94512-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, May 01, 2017 at 10:04:32AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Results checkpointing by filesystem config, as introduced by
> f3c85210f147 ("test-appliance: checkpoint fs configurations that are
> completed") only really makes sense for gce-xfstests, which uses a new
> results directory per GCE instance.  It doesn't make sense for
> kvm-xfstests and android-xfstests because the same results directory may
> be reused for many different test runs, with different kernels and/or
> different sets of tests.  Therefore, for now limit the checkpointing to
> gce-xfstests only.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Nice catch, thanks!   Applied.

				- Ted
