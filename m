Received: from mx1.redhat.com ([209.132.183.28]:49203 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbbJVGev (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 Oct 2015 02:34:51 -0400
Date: Thu, 22 Oct 2015 14:34:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH resend] properly quote strings tested with -n
Message-ID: <20151022063447.GI3558@dhcp-13-216.nay.redhat.com>
References: <561E571D.3010500@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561E571D.3010500@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 14, 2015 at 08:22:37AM -0500, Eric Sandeen wrote:
> Per the Advanced Bash Scripting Guide:
> 
> "The -n test requires that the string be quoted within the test brackets.
> Using an unquoted string with ! -z, or even just the unquoted string
> alone within test bracket normally works, however, this is an unsafe
> practice. Always quote a tested string."
> 
> And indeed:
> 
> $ unset FOOBAR
> $ [ -n $FOOBAR ] || echo nope
> $ [ -n "$FOOBAR" ] || echo nope
> nope
> 
> Ran into this on a box w/o the attr program installed, and passed
> _require_attrs.  Quoting the string fixes this; fix it there
> and other occurrences in common/* as well.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Reviewed-by: Alex Elder <elder@linaro.org>

A quick search shows that all strings after "[ -n " are quoted after
applying this patch.

Reviewed-by: Eryu Guan <eguan@redhat.com>
