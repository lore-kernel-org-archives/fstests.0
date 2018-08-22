Received: from imap.thunk.org ([74.207.234.97]:34496 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbeHVRPZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 Aug 2018 13:15:25 -0400
Date: Wed, 22 Aug 2018 09:50:22 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests: generic/062: Change output of empty attribute
 values
Message-ID: <20180822135022.GK4723@thunk.org>
References: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Su Yue <suy.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 22, 2018 at 04:32:01PM +0800, Su Yue wrote:
> Since v2.4.47 of attr(5)[1], commit 0550d2bc989d (Properly
> set and report empty attribute values) changed output format of
> empty attribute value with quotes.

I think you mean starting with version v2.4.48, right?  "Since
v2.4.47" can easily/commonly be interpreted as "Starting with
v2.4.47".

v2.4.47 was released in 2013, and the commit in question (0550d2bc)
dates from 2015.  v2.4.48 was released very recently, on August 17,
2018.

				- Ted
