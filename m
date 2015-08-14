Received: from sandeen.net ([63.231.237.45]:51466 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104AbbHNQll (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Aug 2015 12:41:41 -0400
Message-ID: <55CE1A40.6080602@sandeen.net>
Date: Fri, 14 Aug 2015 11:41:36 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] ext4/005: add missing out file back
References: <1438759562-7077-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1438759562-7077-1-git-send-email-eguan@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 8/5/15 2:26 AM, Eryu Guan wrote:
> ext4/005.out is missing, add it back.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> I forgot git add tests/ext4/005.out before commit at the first place..

Whoops, yep!

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

>  tests/ext4/005.out | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tests/ext4/005.out
> 
> diff --git a/tests/ext4/005.out b/tests/ext4/005.out
> new file mode 100644
> index 0000000..a5027f1
> --- /dev/null
> +++ b/tests/ext4/005.out
> @@ -0,0 +1,2 @@
> +QA output created by 005
> +Silence is golden
> 

