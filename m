Received: from imap.thunk.org ([74.207.234.97]:47630 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbdI3D6G (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 29 Sep 2017 23:58:06 -0400
Date: Fri, 29 Sep 2017 23:58:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] report: encode XML Character Entities in xUnit report
Message-ID: <20170930035804.qk5mq4xzco6g6sx7@thunk.org>
References: <20170930034621.3036-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170930034621.3036-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 29, 2017 at 11:46:21PM -0400, Theodore Ts'o wrote:
> Since the xUnit report is an XML document, special XML characters such
> as '<', '>', '&', etc. have to be encoded as "&lt;", "&gt;", etc.
> Otherwise programs parsing something like this:
> 
> 	<testcase classname="xfstests.global" name="generic/450" time="0">
> 		<skipped message="Only test on sector size < half of block size" />
> 	</testcase>
> 
> Will get choke the unescaped '<' character in the skipped message.

The last line should be replaced by:

  ... will choke on the unescaped '<' character in the 'messages'
  attribute of the 'skipped' element.


