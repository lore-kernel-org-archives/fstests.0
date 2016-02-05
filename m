Received: from mx1.redhat.com ([209.132.183.28]:53333 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbcBEDd6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 4 Feb 2016 22:33:58 -0500
Date: Fri, 5 Feb 2016 11:33:53 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/3] setup: add section support
Message-ID: <20160205033353.GQ11419@eguan.usersys.redhat.com>
References: <1453340593-10236-1-git-send-email-david@fromorbit.com>
 <1453340593-10236-3-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453340593-10236-3-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 21, 2016 at 12:43:12PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Make the setup command section aware so that it is easy to test
> whether the section config code is generating the correct
> configurations or not.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Looks good to me. To this and the third patch:

Reviewed-by: Eryu Guan <eguan@redhat.com>

Just one minor issue inline

> ---
>  setup | 53 +++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/setup b/setup
> index eb7bdb3..1a41d81 100755
> --- a/setup
> +++ b/setup
> @@ -15,22 +15,63 @@
>  # along with this program; if not, write the Free Software Foundation,
>  # Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>  #
> +usage()
> +{
> +
> +	echo "Usage: $0 [options]"'
> +
> +	-s section		run only specified section(s) from config file
> +'
> +	exit 0
> +}
> +
> +while [ $# -gt 0 ]; do
> +	case "$1" in
> +	-\? | -h | --help) usage ;;
> +	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
> +	*)	usage ;;
> +	esac
> +	shift
> +done
> +
>  if ! . ./common/config
>  then
>      echo "check: failed to source common/config"
>      exit 1
>  fi
>  
> -[ "$USE_EXTERNAL"    = yes ] || USE_EXTERNAL=no
> -[ "$USE_LBD_PATCH"   = yes ] || USE_LBD_PATCH=no
> -[ "$LARGE_SCRATCH_DEV"  = yes ] || LARGE_SCRATCH_DEV=no
> -[ "$USE_ATTR_SECURE" = yes ] || USE_ATTR_SECURE=no
> -[ -z "$FSTYP" ] && FSTYP="xfs"
> +for section in $HOST_OPTIONS_SECTIONS; do
> +	OLD_FSTYP=$FSTYP
> +	OLD_MOUNT_OPTIONS=$MOUNT_OPTIONS
> +	get_next_config $section
> +
> +	# Do we need to run only some sections ?
> +	if [ ! -z "$RUN_SECTION" ]; then
> +		skip=true
> +		for s in $RUN_SECTION; do
> +			if [ $section == $s ]; then
> +				skip=false

I think the for loop can be break once "skip" is false.

Also in the other two "for loop"s in the third patch, only break the
loop once "skip" is true there.

Thanks,
Eryu

> +			fi
> +		done
> +		if $skip; then
> +			continue
> +		fi
> +	fi
> +
> +	[ "$USE_EXTERNAL"    = yes ] || USE_EXTERNAL=no
> +	[ "$USE_LBD_PATCH"   = yes ] || USE_LBD_PATCH=no
> +	[ "$LARGE_SCRATCH_DEV"  = yes ] || LARGE_SCRATCH_DEV=no
> +	[ "$USE_ATTR_SECURE" = yes ] || USE_ATTR_SECURE=no
> +	[ -z "$FSTYP" ] && FSTYP="xfs"
> +
> +	cat <<EOF
> +SECTION       -- $section
>  
> -cat <<EOF
>  TEST: DIR=$TEST_DIR DEV=$TEST_DEV rt=[$TEST_RTDEV] log=[$TEST_LOGDEV]
>  TAPE: dev=[$TAPE_DEV] rmt=[$RMT_TAPE_DEV] rmtirix=[$RMT_TAPE_USER@$RMT_IRIXTAPE_DEV]
>  SCRATCH: MNT=$SCRATCH_MNT DEV=$SCRATCH_DEV rt=[$SCRATCH_RTDEV] log=[$SCRATCH_LOGDEV]
>  VARIABLES: external=$USE_EXTERNAL largeblk=$USE_LBD_PATCH fstyp=$FSTYP
>  	   large_scratch_dev=$LARGE_SCRATCH_DEV attrsecure=$USE_ATTR_SECURE
> +--------
>  EOF
> +done
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
