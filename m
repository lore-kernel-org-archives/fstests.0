Received: from imap.thunk.org ([74.207.234.97]:55548 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965197AbdEWOlb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 May 2017 10:41:31 -0400
Date: Tue, 23 May 2017 10:41:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] kvm-xfstests, gce-xfstests: improve recommended kernel
 config
Message-ID: <20170523144122.nvcnbcxglbk34gwl@thunk.org>
References: <20170522172420.136541-1-ebiggers3@gmail.com>
 <20170523021938.biqavccr6bdyy5sc@thunk.org>
 <20170523025437.GA606@zzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523025437.GA606@zzz>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, May 22, 2017 at 07:54:37PM -0700, Eric Biggers wrote:
> 
> DEBUG_LOCKDEP is for debugging lockdep itself, not for turning on lockdep
> (that's CONFIG_PROVE_LOCKING).  So I don't think it's needed.

Agreed, we don't need to turn on lockdep debugging.

		   	      	      	 - Ted

> I'm fine with leaving on LOCK_STAT; I didn't know there was interest in it.

