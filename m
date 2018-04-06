Received: from imap.thunk.org ([74.207.234.97]:39618 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754094AbeDFN05 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Apr 2018 09:26:57 -0400
Date: Fri, 6 Apr 2018 09:26:55 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] util/get-config: stop sourcing deprecated
 config files
Message-ID: <20180406132655.GC7345@thunk.org>
References: <20180405212010.132258-1-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405212010.132258-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 05, 2018 at 02:20:10PM -0700, Eric Biggers wrote:
> Stop sourcing configs from the deprecated locations $KVM_CONFIG or
> kvm-xfstests/config.custom, in preference to the locations in
> ~/.config/.  kvm-xfstests and gce-xfstests have been warning when
> sourcing from the deprecated locations for almost a year now, so it's
> unlikely that anyone is using them anymore.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

						- Ted
