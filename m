Received: from mail-ig0-f195.google.com ([209.85.213.195]:34594 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759134AbcCDJb4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 4 Mar 2016 04:31:56 -0500
Received: by mail-ig0-f195.google.com with SMTP id sv7so1684680igc.1
        for <fstests@vger.kernel.org>; Fri, 04 Mar 2016 01:31:55 -0800 (PST)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <478b11f8a7ffe7d491227ab536418f214e7d346c.1457028701.git.dsterba@suse.com>
References: <cover.1457028701.git.dsterba@suse.com>
	<478b11f8a7ffe7d491227ab536418f214e7d346c.1457028701.git.dsterba@suse.com>
Date: Fri, 4 Mar 2016 09:31:54 +0000
Message-ID: <CAL3q7H4om2sFuM-z3pavC_pF1MA2hUmmVZi8ySL24oiyxo=zMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] filter.btrfs: new filter for property messages
From: Filipe Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 3, 2016 at 6:16 PM, David Sterba <dsterba@suse.com> wrote:
> The error message in newer btrfs utilities contains name of the
> property, we want to filter it out so it matches golden output. There's
> an optional parameter with property name that is matched against the
> command output.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  common/filter.btrfs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index 9bb64792f14f..380454399834 100644
> --- a/common/filter.btrfs
> +++ b/common/filter.btrfs
> @@ -68,5 +68,17 @@ _filter_btrfs_subvol_delete()
>
>  }
>
> +# filter name of the property from the output, optionally verify against $1
> +# recognized message(s):
> +#  "object is not compatible with property: label"
> +_filter_btrfs_prop_error()
> +{
> +       if ! [ -z "$1" ]; then
> +               sed -e "s/\(compatible with property\): $1/\1/"
> +       else
> +               sed -e "s/^\(.*compatible with property\).*/\1/"
> +       fi
> +}
> +
>  # make sure this script returns success
>  /bin/true
> --
> 1.8.4.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Filipe David Manana,

"Reasonable men adapt themselves to the world.
 Unreasonable men adapt the world to themselves.
 That's why all progress depends on unreasonable men."
