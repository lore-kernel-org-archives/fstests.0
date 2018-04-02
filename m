Received: from imap.thunk.org ([74.207.234.97]:54002 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756523AbeDBS4Q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 2 Apr 2018 14:56:16 -0400
Date: Mon, 2 Apr 2018 14:56:14 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] test-appliance: fix use of undefined
 variable in gen_results_summary
Message-ID: <20180402185614.GD32730@thunk.org>
References: <20180402171413.63324-1-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402171413.63324-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 02, 2018 at 10:14:13AM -0700, Eric Biggers wrote:
> This fixes the following Python error when no tests were run:
> 
>     Traceback (most recent call last):
>       File "/usr/local/bin/gen_results_summary", line 22, in <module>
> 	main()
>       File "/usr/local/bin/gen_results_summary", line 19, in main
> 	sys.exit('No results file found in ' + results_dir)
>     NameError: global name 'results_dir' is not defined
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
