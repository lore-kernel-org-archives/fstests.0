Received: from mail-wm0-f44.google.com ([74.125.82.44]:37777 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbcFNPoo (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2016 11:44:44 -0400
Received: by mail-wm0-f44.google.com with SMTP id k204so129049379wmk.0
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2016 08:44:44 -0700 (PDT)
Subject: Re: [PATCH 2/2] generic/042: add to auto group
References: <1465916890-28135-1-git-send-email-hch@lst.de>
 <1465916890-28135-3-git-send-email-hch@lst.de>
From: Omer Zilberberg <omzg@plexistor.com>
Message-ID: <3280bc48-96f8-6653-933b-0154f0fa4a3e@plexistor.com>
Date: Tue, 14 Jun 2016 18:44:40 +0300
MIME-Version: 1.0
In-Reply-To: <1465916890-28135-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 06/14/2016 06:08 PM, Christoph Hellwig wrote:
> This is an odd one as it's in the quick group but not the auto one.
> And it actually fails on XFS for me..
Please note that this was removed from 'auto' in commit:
7721b85 generic/042: remove from the 'auto' group
I don't know whether the original reasons for this are still relevant...
just FYI
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index 217ffaa..2daff9f 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -44,7 +44,7 @@
>  039 metadata auto quick
>  040 metadata auto quick
>  041 metadata auto quick
> -042 quick rw
> +042 auto quick rw
>  043 metadata log auto
>  044 metadata log auto
>  045 metadata log auto
> 
