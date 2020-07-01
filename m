Return-Path: <SRS0=3sLM=AM=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72AAC433E1
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 10:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71AE020722
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 10:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="hJiNphGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgGAKKN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:10:13 -0400
Received: from mail.synology.com ([211.23.38.101]:53262 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729840AbgGAKKM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 1 Jul 2020 06:10:12 -0400
Subject: Re: [PATCH] btrfs: speedup mount time with force readahead chunk tree
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1593598211; bh=8/tC1L2idaec/iwv4AyOFpoJWtMvFYvzC12VBpLt61o=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=hJiNphGGIQVDetY+LE1LfOOGVteG61eoT3n5aDyXhnmRaz0IGoBYPAmr2U8hRK9/F
         9mMLKg4B4qz8rchaEH4m+vQTagPBGr/yyGvX1pcKyADGm0qajZLNJvqOabWOTEM932
         GwCnli9TUnzcJ3P+GsoAwZzppbdBtlro0jk7EdLg=
To:     fstests@vger.kernel.org
References: <20200701092449.19545-1-robbieko@synology.com>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <a2093c30-a87d-5dc0-26c7-6f4f45660425@synology.com>
Date:   Wed, 1 Jul 2020 18:10:10 +0800
MIME-Version: 1.0
In-Reply-To: <20200701092449.19545-1-robbieko@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

please ignore this.

> From: Robbie Ko <robbieko@synology.com>
>
> When mounting, we always need to read the whole chunk tree,
> when there are too many chunk items, most of the time is
> spent on btrfs_read_chunk_tree, because we only read one
> leaf at a time.
>
> We fix this by adding a new readahead mode READA_FORWARD_FORCE,
> which reads all the leaves after the key in the node when
> reading a level 1 node.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>   fs/btrfs/ctree.c   | 7 +++++--
>   fs/btrfs/ctree.h   | 2 +-
>   fs/btrfs/volumes.c | 1 +
>   3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 3a7648bff42c..abb9108e2d7d 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2194,7 +2194,7 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
>   			if (nr == 0)
>   				break;
>   			nr--;
> -		} else if (path->reada == READA_FORWARD) {
> +		} else if (path->reada == READA_FORWARD || path->reada == READA_FORWARD_FORCE) {
>   			nr++;
>   			if (nr >= nritems)
>   				break;
> @@ -2205,12 +2205,15 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
>   				break;
>   		}
>   		search = btrfs_node_blockptr(node, nr);
> -		if ((search <= target && target - search <= 65536) ||
> +		if ((path->reada == READA_FORWARD_FORCE) ||
> +		    (search <= target && target - search <= 65536) ||
>   		    (search > target && search - target <= 65536)) {
>   			readahead_tree_block(fs_info, search);
>   			nread += blocksize;
>   		}
>   		nscan++;
> +		if (path->reada == READA_FORWARD_FORCE)
> +			continue;
>   		if ((nread > 65536 || nscan > 32))
>   			break;
>   	}
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d404cce8ae40..808bcbdc9530 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -353,7 +353,7 @@ struct btrfs_node {
>    * The slots array records the index of the item or block pointer
>    * used while walking the tree.
>    */
> -enum { READA_NONE, READA_BACK, READA_FORWARD };
> +enum { READA_NONE, READA_BACK, READA_FORWARD, READA_FORWARD_FORCE };
>   struct btrfs_path {
>   	struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
>   	int slots[BTRFS_MAX_LEVEL];
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0d6e785bcb98..78fd65abff69 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7043,6 +7043,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   	path = btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
> +	path->reada = READA_FORWARD_FORCE;
>   
>   	/*
>   	 * uuid_mutex is needed only if we are mounting a sprout FS
