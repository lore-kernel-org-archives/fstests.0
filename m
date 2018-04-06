Received: from imap.thunk.org ([74.207.234.97]:38222 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeDFCNW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Apr 2018 22:13:22 -0400
Date: Thu, 5 Apr 2018 22:13:20 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] util/parse_cli: use getopt to parse the
 options
Message-ID: <20180406021320.GB7345@thunk.org>
References: <20180405210644.128564-1-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405210644.128564-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 05, 2018 at 02:06:44PM -0700, Eric Biggers wrote:
> Use getopt to parse the options rather than the custom code that
> iterates through $@.  This fixes many anomalies, such as long options
> being accepted in the form '--opt ARG' but not '--opt=ARG'.

getopt is in util-linux, which implies that if there is anyone trying
to launch gce-xfstests from MacOS, it won't work any more with this
commit.  I don't *think* this is a problem, and if so a workaround is
to use Cloud Shell[1], but if this change will break anyone, please
speak now....

						- Ted
